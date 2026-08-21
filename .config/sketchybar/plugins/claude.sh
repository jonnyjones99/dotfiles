#!/usr/bin/env bash
# Renders live Claude Code sessions on the bar. State written by the
# claude-session-state.sh hook, one file per session_id:
#   label \t status \t paneid \t session   (label = session:window.pane)
# Icon colour = worst aggregate state. Click jumps to the neediest pane.
source "$CONFIG_DIR/colors.sh"
STATE_DIR="$HOME/.claude/state/claude-sessions"
PRUNE_MIN=720   # ponytail: prune entries >12h old (covers sessions killed without SessionEnd)

declare -A groups   # session -> " w.p<glyph> w.p<glyph> ..."
order=""            # session names in first-seen order
agg="idle"          # precedence: needs > working > idle
target_pane=""      # tmux pane id (%N) to jump to on click
target_sess=""
target_rank=0       # needs=3 > working=2 > idle=1
count=0

if [ -d "$STATE_DIR" ]; then
  find "$STATE_DIR" -type f -mmin +$PRUNE_MIN -delete 2>/dev/null
  for f in "$STATE_DIR"/*; do
    [ -e "$f" ] || continue
    IFS=$'\t' read -r name status pane sess < "$f"
    case "$status" in
      needs)   glyph="!"; agg="needs"; rank=3 ;;
      working) glyph="…"; [ "$agg" != "needs" ] && agg="working"; rank=2 ;;
      *)       glyph="✓"; rank=1 ;;
    esac
    if [ "$rank" -gt "$target_rank" ]; then
      target_rank=$rank; target_pane="$pane"; target_sess="$sess"
    fi
    # Collapse repeated session prefix: group panes under their session.
    if [[ "$name" == *:* ]]; then s="${name%%:*}"; wp="${name#*:}"; else s="$name"; wp=""; fi
    [ -z "${groups[$s]+x}" ] && order="$order $s"
    groups["$s"]="${groups[$s]} ${wp}${glyph}"
    count=$((count + 1))
  done
fi

# Build "SESSION w.p… w.p!  OTHER w.p✓" — session shown once per group.
label=""
for s in $order; do label="$label  ${s}${groups[$s]}"; done

if [ "$count" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

case "$agg" in
  needs)   col="$RED" ;;
  working) col="$YELLOW" ;;
  *)       col="$GREEN" ;;
esac

# Click jumps the attached tmux client to the exact pane of the neediest
# session (switch session, then select its window + pane), then raises the
# terminal. ponytail: targets the most-recent client if you run several.
TMUX_BIN="/opt/homebrew/bin/tmux"
if [ -n "$target_pane" ]; then
  click="$TMUX_BIN switch-client -t '$target_sess'; $TMUX_BIN select-window -t '$target_pane'; $TMUX_BIN select-pane -t '$target_pane'; open -a Alacritty"
else
  click="open -a Alacritty"
fi

# Only the icon carries the aggregate colour (red=any needs you / yellow=any
# working / green=all idle). Label stays neutral so an idle ✓ never shows red.
sketchybar --set "$NAME" drawing=on icon.color="$col" label.color="$TEXT" \
  label="${label# }" click_script="$click"
