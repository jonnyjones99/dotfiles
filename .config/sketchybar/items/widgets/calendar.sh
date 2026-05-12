#!/usr/bin/env bash
# Calendar enhancements: upcoming-event pill + 7-day hover popup on the date item.

# Invisible spacer between status_bracket (added earlier) and event_bracket
# (added below). Right-position items are placed right-to-left in insertion
# order, so this MUST be added before event_pill to sit between them.
# Brackets include their items' outer padding in their bg, so a standalone
# non-bracketed item is the only reliable way to get a true gap between two
# brackets.
sketchybar --add item event_gap right \
           --set event_gap \
              width=8 \
              background.drawing=off

# ----- Event pill (own island) -----
sketchybar --add item event_pill right \
           --set event_pill \
              drawing=off \
              updates=on \
              update_freq=60 \
              icon=󰺁 \
              icon.color="$PEACH" \
              icon.font="JetBrainsMono Nerd Font:Bold:14.0" \
              label.color="$TEXT" \
              label.padding_left=4 \
              label.padding_right=8 \
              label.max_chars=28 \
              script="$PLUGIN_DIR/event_pill.sh" \
              click_script="open -a Calendar"

sketchybar --add bracket event_bracket event_pill \
           --set event_bracket \
              background.color="$BRACKET_BG" \
              background.corner_radius=12 \
              background.height=28 \
              background.padding_left=4 \
              background.padding_right=4

# ----- Date popup configuration -----
# Reuses the existing date item (defined in items/widgets/clock.sh).
sketchybar --set date \
              click_script="open -a Calendar" \
              popup.background.color="$POPUP_BG" \
              popup.background.border_color="$ITEM_BG_ACTIVE" \
              popup.background.border_width=1 \
              popup.background.corner_radius=10 \
              popup.horizontal=off \
              popup.align=right \
              popup.y_offset=4 \
           --subscribe date mouse.entered mouse.exited mouse.exited.global

# ----- Pre-allocate 16 popup item slots -----
# event_slot.0 is the header; event_slot.1..15 are event rows.
# date.sh fills these on hover and toggles drawing.
sketchybar --add item event_slot.0 popup.date \
           --set event_slot.0 \
              drawing=off \
              icon.font="JetBrainsMono Nerd Font:Bold:13.0" \
              icon.color="$LAVENDER" \
              label.font="JetBrainsMono Nerd Font:Bold:12.0" \
              label.color="$SUBTEXT" \
              label.padding_right=12 \
              icon.padding_left=12 \
              background.padding_left=0 \
              background.padding_right=0

for i in $(seq 1 15); do
  sketchybar --add item "event_slot.$i" popup.date \
             --set "event_slot.$i" \
                drawing=off \
                icon.font="JetBrainsMono Nerd Font:Regular:12.0" \
                icon.color="$SUBTEXT" \
                label.font="JetBrainsMono Nerd Font:Regular:12.0" \
                label.color="$TEXT" \
                label.padding_right=12 \
                icon.padding_left=12 \
                label.max_chars=40 \
                background.padding_left=0 \
                background.padding_right=0
done

# Run event_pill.sh once now so the pill reflects current state immediately,
# rather than waiting for the first update_freq tick (~60s).
NAME=event_pill bash "$PLUGIN_DIR/event_pill.sh"
