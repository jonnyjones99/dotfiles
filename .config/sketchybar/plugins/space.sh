#!/usr/bin/env bash
# Per-space pill: highlight if active + show focused-app icon.

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

SID="${NAME##*.}"

SPACE_COUNT=$(yabai -m query --spaces 2>/dev/null | jq 'length' 2>/dev/null)
if [ -n "$SPACE_COUNT" ] && [ "$SID" -gt "$SPACE_COUNT" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi
sketchybar --set "$NAME" drawing=on

APP=$(yabai -m query --windows --space "$SID" 2>/dev/null \
        | jq -r 'map(select(.["has-focus"]==true))[0].app
                 // map(select(.["is-visible"]==true))[0].app
                 // .[0].app
                 // empty')

if [ -n "$APP" ]; then
  LABEL=$(icon_for "$APP")
else
  LABEL=""
fi

ACTIVE_SID=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index // empty')

if [ "$SID" = "$ACTIVE_SID" ]; then
  sketchybar --set "$NAME" \
    background.color="$ITEM_BG_ACTIVE" \
    icon.color="$LAVENDER" \
    label="$LABEL" \
    label.color="$TEXT"
else
  sketchybar --set "$NAME" \
    background.color="$ITEM_BG_INACTIVE" \
    icon.color="$TEXT" \
    label="$LABEL" \
    label.color="$SUBTEXT"
fi
