#!/usr/bin/env bash
# mem item handler.
#  - Default ($SENDER empty): refreshes the bar label/color and updates
#    the network state file so popup rates are ready when hovered.
#  - mouse.entered: populates popup slots and shows the popup.
#  - mouse.exited / mouse.exited.global: hides the popup.
#
# State files (each holds a few bytes, overwritten not appended):
#   /tmp/sketchybar-net-totals -> "<epoch> <rx_bytes> <tx_bytes>"
#                                 last raw byte counters; used to compute deltas.
#   /tmp/sketchybar-net-rates  -> "<rx_bytes_per_sec> <tx_bytes_per_sec>"
#                                 latest computed rate; read by the popup.

source "$CONFIG_DIR/colors.sh"

NET_TOTALS=/tmp/sketchybar-net-totals
NET_RATES=/tmp/sketchybar-net-rates

# --- helpers ---------------------------------------------------------------

mem_used_bytes() {
  local ps tot
  ps=$(pagesize)
  tot=$(sysctl -n hw.memsize)
  vm_stat | awk -v ps="$ps" -v total="$tot" '
    /Pages active/                 { gsub(/\./, "", $3); a = $3 }
    /Pages wired down/             { gsub(/\./, "", $4); w = $4 }
    /Pages occupied by compressor/ { gsub(/\./, "", $5); c = $5 }
    END { printf "%d %d", (a + w + c) * ps, total }
  '
}

human_bytes() {
  awk -v b="$1" 'BEGIN {
    if      (b >= 1073741824) printf "%.1f GB", b/1073741824
    else if (b >= 1048576)    printf "%.0f MB", b/1048576
    else if (b >= 1024)       printf "%.0f KB", b/1024
    else                      printf "%d B",   b
  }'
}

human_rate() {
  awk -v b="$1" 'BEGIN {
    if      (b >= 1048576) printf "%.1f MB/s", b/1048576
    else if (b >= 1024)    printf "%.0f KB/s", b/1024
    else                   printf "%d B/s",   b
  }'
}

# Sums Ibytes / Obytes across physical interfaces (en*) using the
# <Link#N> row, which carries the cumulative byte counters.
read_net_counters() {
  netstat -ibn | awk '
    /^en[0-9]+/ && $3 ~ /^<Link#/ { rx += $7; tx += $10 }
    END { printf "%d %d", rx+0, tx+0 }
  '
}

# --- background tick handlers ---------------------------------------------

update_bar() {
  local used total pct color
  read used total < <(mem_used_bytes)
  pct=$(( used * 100 / total ))

  if   [ "$pct" -ge 90 ]; then color=$RED
  elif [ "$pct" -ge 70 ]; then color=$YELLOW
  else                         color=$GREEN
  fi

  sketchybar --set mem icon.color="$color" label="${pct}%"
}

update_net_state() {
  local now rx tx
  now=$(date +%s)
  read rx tx < <(read_net_counters)

  if [ -f "$NET_TOTALS" ]; then
    local prev_t prev_rx prev_tx dt drx dtx
    read prev_t prev_rx prev_tx < "$NET_TOTALS"
    dt=$(( now - prev_t ))
    if [ "$dt" -gt 0 ]; then
      drx=$(( (rx - prev_rx) / dt ))
      dtx=$(( (tx - prev_tx) / dt ))
      [ "$drx" -lt 0 ] && drx=0
      [ "$dtx" -lt 0 ] && dtx=0
      echo "$drx $dtx" > "$NET_RATES"
    fi
  fi
  echo "$now $rx $tx" > "$NET_TOTALS"
}

# --- popup -----------------------------------------------------------------

populate_popup() {
  local i used total pct used_h total_h cpu_idle cpu_pct load
  local drx dtx down up

  # Reset all slots (calendar pattern — avoids stale rows when a section shrinks).
  # mem_slot.0 stays hidden — kept allocated so existing slot indices below
  # don't have to shift if a header is reintroduced later.
  for i in $(seq 0 12); do
    sketchybar --set "mem_slot.$i" drawing=off label="" icon=""
  done

  # --- Memory ---
  read used total < <(mem_used_bytes)
  pct=$(( used * 100 / total ))
  used_h=$(human_bytes "$used")
  total_h=$(human_bytes "$total")

  sketchybar --set mem_slot.1 drawing=on icon="" \
    label="── Memory ──" label.color="$LAVENDER"
  sketchybar --set mem_slot.2 drawing=on icon="" \
    label="$used_h / $total_h  (${pct}%)"

  # Top 3 processes by RSS (resident memory). -m sorts by mem, -ww keeps
  # full command width. Skip the header row.
  i=3
  while read -r rss comm; do
    [ "$i" -gt 5 ] && break
    [ -z "$rss" ] && continue
    local name rss_h
    name=$(basename "$comm")
    rss_h=$(human_bytes $(( rss * 1024 )))
    sketchybar --set "mem_slot.$i" drawing=on icon="" \
      label="$(printf '%-9s %s' "$rss_h" "$name")"
    i=$(( i + 1 ))
  done < <(ps -A -m -o rss=,comm= 2>/dev/null | head -3)

  # --- Network ---
  sketchybar --set mem_slot.6 drawing=on icon="" \
    label="── Network ──" label.color="$LAVENDER"

  if [ -f "$NET_RATES" ]; then
    read drx dtx < "$NET_RATES"
    down=$(human_rate "$drx")
    up=$(human_rate "$dtx")
    sketchybar --set mem_slot.7 drawing=on icon="" \
      label="$(printf '↓ %-12s ↑ %s' "$down" "$up")"
  else
    sketchybar --set mem_slot.7 drawing=on icon="" \
      label="sampling…" label.color="$SUBTEXT"
  fi

  # --- CPU ---
  sketchybar --set mem_slot.8 drawing=on icon="" \
    label="── CPU ──" label.color="$LAVENDER"

  # top -l 2 -s 1: take two samples 1s apart; second sample is accurate.
  # This is a deliberate 1s blocking call, only paid on hover.
  local top_out
  top_out=$(top -l 2 -s 1 -n 3 -o cpu -stats pid,command,cpu 2>/dev/null)
  cpu_idle=$(echo "$top_out" | grep "CPU usage" | tail -n 1 | \
             awk '{ for (k=1; k<=NF; k++) if ($k ~ /idle/) { gsub("%","",$(k-1)); print $(k-1); exit } }')
  [ -z "$cpu_idle" ] && cpu_idle=0
  cpu_pct=$(awk -v i="$cpu_idle" 'BEGIN { v=100-i; if (v<0) v=0; printf "%d", v }')
  load=$(sysctl -n vm.loadavg | tr -d '{}' | awk '{ printf "%s %s %s", $1, $2, $3 }')

  sketchybar --set mem_slot.9 drawing=on icon="" \
    label="$(printf '%-3s%%   load %s' "$cpu_pct" "$load")"

  # Top 3 processes by CPU%.
  i=10
  while read -r pcpu comm; do
    [ "$i" -gt 12 ] && break
    [ -z "$pcpu" ] && continue
    local name
    name=$(basename "$comm")
    sketchybar --set "mem_slot.$i" drawing=on icon="" \
      label="$(printf '%-9s %s' "${pcpu}%" "$name")"
    i=$(( i + 1 ))
  done < <(ps -A -r -o pcpu=,comm= 2>/dev/null | head -3)
}

# --- dispatch --------------------------------------------------------------

case "$SENDER" in
  mouse.exited|mouse.exited.global)
    sketchybar --set "$NAME" popup.drawing=off
    exit 0
    ;;
  mouse.entered)
    populate_popup
    sketchybar --set "$NAME" popup.drawing=on
    exit 0
    ;;
esac

update_bar
update_net_state
