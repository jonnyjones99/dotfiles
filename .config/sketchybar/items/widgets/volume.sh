#!/usr/bin/env bash
# Volume widget — initial state set from current system volume, then updated on volume_change.

sketchybar --add item volume right \
           --set volume \
              icon=󰕾 \
              icon.color="$SKY" \
              icon.font="JetBrainsMono Nerd Font:Bold:16.0" \
              label.color="$TEXT" \
              label.padding_right=10 \
              script="$PLUGIN_DIR/volume.sh" \
              updates=on \
           --subscribe volume volume_change
