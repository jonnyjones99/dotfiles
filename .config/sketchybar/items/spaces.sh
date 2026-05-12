#!/usr/bin/env bash
# Left island: yabai mission-control spaces with focused-app icon per pill.

MAX_SPACES=10
SPACE_NAMES=()

for sid in $(seq 1 "$MAX_SPACES"); do
  sketchybar --add space "space.$sid" left \
             --set "space.$sid" \
                space="$sid" \
                icon="$sid" \
                icon.padding_left=8 \
                icon.padding_right=4 \
                icon.color="$TEXT" \
                icon.font="JetBrainsMono Nerd Font:Bold:13.0" \
                label="" \
                label.padding_left=0 \
                label.padding_right=8 \
                label.color="$SUBTEXT" \
                label.font="JetBrainsMono Nerd Font:Regular:15.0" \
                background.color="$ITEM_BG_INACTIVE" \
                background.corner_radius=8 \
                background.height=22 \
                background.padding_left=2 \
                background.padding_right=2 \
                script="$PLUGIN_DIR/space.sh" \
                click_script="yabai -m space --focus $sid"
  SPACE_NAMES+=("space.$sid")
done

sketchybar --add bracket spaces_bracket "${SPACE_NAMES[@]}" \
           --set spaces_bracket \
              background.color="$BRACKET_BG" \
              background.corner_radius=12 \
              background.height=28 \
              background.padding_left=4 \
              background.padding_right=4

# Each space pill listens for built-in space change AND our custom
# windows_on_spaces event (triggered by yabai signals — see yabairc).
for sid in $(seq 1 "$MAX_SPACES"); do
  sketchybar --subscribe "space.$sid" space_change windows_on_spaces
done
