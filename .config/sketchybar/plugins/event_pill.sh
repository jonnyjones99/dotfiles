#!/usr/bin/env bash
# Toggles the event_pill: visible only when an event starts within the next 60 minutes.

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/calendar_lib.sh"

WINDOW_MINUTES=60

next=$(next_event_today)

if [ -z "$next" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

start_epoch=${next%%|*}
rest=${next#*|}
start_hm=${rest%%|*}
title=${rest#*|}

now=$(date '+%s')
diff_sec=$(( start_epoch - now ))
diff_min=$(( diff_sec / 60 ))

if [ "$diff_min" -gt "$WINDOW_MINUTES" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

# Color shifts as event approaches.
if [ "$diff_min" -le 5 ]; then
  COLOR=$RED
elif [ "$diff_min" -le 15 ]; then
  COLOR=$PEACH
else
  COLOR=$YELLOW
fi

human=$(human_until "$start_epoch")

sketchybar --set "$NAME" \
  drawing=on \
  icon.color="$COLOR" \
  label="$human · $title"
