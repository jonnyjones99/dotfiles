#!/usr/bin/env bash
# Memory usage widget — joins the existing status_bracket (defined in
# clock.sh) so it shares an island with volume/battery/clock.
#
# Hover opens a popup with three sections: top memory consumers,
# live network throughput, and CPU usage + top CPU consumers.
# Click launches btop in a new Alacritty window.
#
# UTF-8 byte escapes are used for the icon because pasting some
# PUA codepoints into source files can corrupt them in transit.

# nf-fa-microchip (U+F2DB) — chip glyph. The F500+ range (where
# nf-fa-memory lives) isn't present in this build of JetBrainsMono
# Nerd Font, so we stick to icons under U+F2FF for reliability.
MEM_ICON=$(printf '\xef\x8b\x9b')

sketchybar --add item mem right \
           --set mem \
              update_freq=5 \
              icon="$MEM_ICON" \
              icon.font="JetBrainsMono Nerd Font:Bold:14.0" \
              icon.color="$GREEN" \
              label.color="$TEXT" \
              label.padding_right=10 \
              script="$PLUGIN_DIR/system.sh" \
              click_script="/opt/homebrew/bin/alacritty -e /opt/homebrew/bin/btop" \
              popup.background.color="$POPUP_BG" \
              popup.background.border_color="$ITEM_BG_ACTIVE" \
              popup.background.border_width=1 \
              popup.background.corner_radius=10 \
              popup.horizontal=off \
              popup.align=center \
              popup.y_offset=4 \
           --subscribe mem mouse.entered mouse.exited mouse.exited.global

# ----- Pre-allocate popup slots -----
# Layout (top → bottom):
#   0      reserved (currently hidden — leave for a future header row)
#   1      "── Memory ──"
#   2      used / total summary
#   3-5    top 3 processes by RSS
#   6      "── Network ──"
#   7      down/up rates
#   8      "── CPU ──"
#   9      overall % + load average
#   10-12  top 3 processes by CPU
sketchybar --add item mem_slot.0 popup.mem \
           --set mem_slot.0 \
              drawing=off \
              icon.font="JetBrainsMono Nerd Font:Bold:13.0" \
              icon.color="$LAVENDER" \
              label.font="JetBrainsMono Nerd Font:Bold:12.0" \
              label.color="$SUBTEXT" \
              label.padding_right=12 \
              icon.padding_left=12 \
              background.padding_left=0 \
              background.padding_right=0

for i in $(seq 1 12); do
  sketchybar --add item "mem_slot.$i" popup.mem \
             --set "mem_slot.$i" \
                drawing=off \
                icon.font="JetBrainsMono Nerd Font:Regular:12.0" \
                icon.color="$SUBTEXT" \
                label.font="JetBrainsMono Nerd Font:Regular:12.0" \
                label.color="$TEXT" \
                label.padding_right=12 \
                icon.padding_left=12 \
                label.max_chars=42 \
                background.padding_left=0 \
                background.padding_right=0
done

# Run once now so the bar reflects current state immediately.
NAME=mem bash "$PLUGIN_DIR/system.sh"
