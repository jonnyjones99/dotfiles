#!/usr/bin/env bash
# Date item handler.
#  - Default ($SENDER empty): updates the visible date label.
#  - mouse.entered: refreshes popup rows from icalBuddy and shows the popup.
#  - mouse.exited / mouse.exited.global: hides the popup.

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/calendar_lib.sh"

case "$SENDER" in
  mouse.exited|mouse.exited.global)
    sketchybar --set "$NAME" popup.drawing=off
    exit 0
    ;;
  mouse.entered)
    # Hide all slots first
    for i in $(seq 0 15); do
      sketchybar --set "event_slot.$i" drawing=off label="" icon=""
    done

    from=$(date "+%Y-%m-%d")
    to=$(date -v+7d "+%Y-%m-%d")

    # Header
    sketchybar --set event_slot.0 \
       drawing=on \
       icon="" \
       label="Next 7 days"

    slot=1
    last_date=""
    while IFS="|" read -r datetime title; do
      [ -z "$datetime" ] && continue
      [ "$slot" -gt 15 ] && break

      case "$datetime" in
        *" at "*)
          d=${datetime%% at *}
          rest=${datetime#* at }
          start=${rest%% - *}
          time_str="$start"
          ;;
        *)
          d="$datetime"
          time_str="all-day"
          ;;
      esac

      # Insert a date heading when the day changes
      if [ "$d" != "$last_date" ]; then
        if [ "$slot" -gt 15 ]; then break; fi
        heading=$(date -j -f "%Y-%m-%d" "$d" "+%a %d %b" 2>/dev/null)
        sketchybar --set "event_slot.$slot" \
          drawing=on \
          icon="" \
          label="── $heading ──" \
          label.color="$LAVENDER"
        slot=$((slot + 1))
        last_date="$d"
        [ "$slot" -gt 15 ] && break
      fi

      sketchybar --set "event_slot.$slot" \
        drawing=on \
        icon="󰝦" \
        icon.color="$SUBTEXT" \
        label="$time_str  $title" \
        label.color="$TEXT"
      slot=$((slot + 1))
    done < <(fetch_events_raw "$from" "$to")

    if [ "$slot" -eq 1 ]; then
      sketchybar --set event_slot.1 \
        drawing=on \
        icon="󰙎" \
        label="No events in the next 7 days" \
        label.color="$SUBTEXT"
    fi

    sketchybar --set "$NAME" popup.drawing=on
    exit 0
    ;;
esac

# Default: update the visible date label
sketchybar --set "$NAME" label="$(date "+%a %d/%m")"
