#!/usr/bin/env bash
# Battery widget — updates every 2 minutes and on power/wake events.

sketchybar --add item battery right \
           --set battery \
              update_freq=120 \
              icon=󰁹 \
              icon.color="$PEACH" \
              icon.font="JetBrainsMono Nerd Font:Bold:16.0" \
              label.color="$TEXT" \
              label.padding_right=10 \
              script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
