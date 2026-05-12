#!/usr/bin/env bash
# Music widget — currently-playing track from Apple Music, with animated
# block-char "waveform" while playing and a 5-min pause auto-hide.
#
# Positioned on the LEFT side, added last so it sits flush against the
# notch (the bar's notch_width keeps left items out of the notch area).

# 8px gap between spaces_bracket and music_bracket. Added before music_pill
# so it lands between them.
sketchybar --add item music_gap left \
           --set music_gap \
              width=8 \
              background.drawing=off

# ----- Music pill -----
# label.max_chars defines the fixed visible width; longer labels scroll
# automatically because the bar has scroll_texts=on.
sketchybar --add item music_pill left \
           --set music_pill \
              drawing=off \
              updates=on \
              update_freq=1 \
              icon=▂▄▅ \
              icon.color="$GREEN" \
              icon.font="JetBrainsMono Nerd Font:Bold:13.0" \
              label.color="$TEXT" \
              label.padding_left=4 \
              label.padding_right=8 \
              label.max_chars=24 \
              label.scroll_duration=240 \
              scroll_texts=off \
              script="$PLUGIN_DIR/music.sh" \
              click_script="open -a Music"

sketchybar --add bracket music_bracket music_pill \
           --set music_bracket \
              background.color="$BRACKET_BG" \
              background.corner_radius=12 \
              background.height=28 \
              background.padding_left=4 \
              background.padding_right=4

# Run once now so state is correct without waiting for the first tick.
NAME=music_pill bash "$PLUGIN_DIR/music.sh"
