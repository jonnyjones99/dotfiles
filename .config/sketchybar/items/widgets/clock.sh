#!/usr/bin/env bash
# Date and time widgets.
#
# Right-side items are inserted right-to-left, so the order of these
# two --add calls determines that date ends up to the right of time.
# The status_bracket that groups these with volume/battery/mem is
# defined in sketchybarrc, after all member items exist.

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
