#!/usr/bin/env bash

# Get volume from event payload when triggered by volume_change,
# otherwise query the system directly (initial load / forced update).
if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
else
  VOLUME=$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)
fi

# If muted or unset, osascript may return "missing value".
case "$VOLUME" in
  ''|*[!0-9]*) VOLUME=0 ;;
esac

case "$VOLUME" in
  [6-9][0-9]|100)   ICON="󰕾" ;;
  [3-5][0-9])       ICON="󰖀" ;;
  [1-9]|[1-2][0-9]) ICON="󰕿" ;;
  *)                ICON="󰖁" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
