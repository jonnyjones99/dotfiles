#!/usr/bin/env bash
source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo '[0-9]+%' | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  100|9[0-9]) ICON=󰂂 ;;
  8[0-9])     ICON=󰂁 ;;
  7[0-9])     ICON=󰂀 ;;
  6[0-9])     ICON=󰁿 ;;
  5[0-9])     ICON=󰁾 ;;
  4[0-9])     ICON=󰁽 ;;
  3[0-9])     ICON=󰁼 ;;
  2[0-9])     ICON=󰁻 ;;
  1[0-9])     ICON=󰁺 ;;
  *)          ICON=󰁺 ;;
esac

if [ -n "$CHARGING" ]; then
  ICON=󰂄
  COLOR=$MAUVE
elif [ "$PERCENTAGE" -lt 20 ]; then
  COLOR=$RED
elif [ "$PERCENTAGE" -lt 60 ]; then
  COLOR=$YELLOW
else
  COLOR=$GREEN
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
