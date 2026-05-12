#!/usr/bin/env bash
# Date and time widgets + right-island bracket grouping.

sketchybar --add item date right \
           --set date \
              update_freq=30 \
              icon=󰃭 \
              icon.color="$LAVENDER" \
              icon.font="JetBrainsMono Nerd Font:Bold:14.0" \
              label.color="$TEXT" \
              label.padding_right=8 \
              script="$PLUGIN_DIR/date.sh"

sketchybar --add item time right \
           --set time \
              update_freq=10 \
              icon=󰅐 \
              icon.color="$MAUVE" \
              icon.font="JetBrainsMono Nerd Font:Bold:14.0" \
              label.color="$TEXT" \
              label.padding_right=10 \
              script="$PLUGIN_DIR/time.sh"

sketchybar --add bracket status_bracket volume battery date time \
           --set status_bracket \
              background.color="$BRACKET_BG" \
              background.corner_radius=12 \
              background.height=28 \
              background.padding_left=4 \
              background.padding_right=4
