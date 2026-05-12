#!/usr/bin/env bash
# Updates music_pill based on Apple Music state.
#   playing -> play glyph (green) + Track — Artist
#   paused  -> pause glyph (subtext) + Track — Artist
#              ...auto-hides after PAUSE_TIMEOUT seconds of continuous pause
#   stopped / Music not running -> hidden
#
# State files (each holds a single epoch timestamp, overwritten each tick):
#   pause-since  -> when the current pause began; cleared only on "playing"
#                   so transient "stopped" blips during track changes don't
#                   reset the auto-hide timer.
#   scroll-start -> when the current scroll cycle began; cleared on pause /
#                   stop so scrolling restarts cleanly when playback resumes.

source "$CONFIG_DIR/colors.sh"

STATE_FILE="/tmp/sketchybar-music-pause-since"
SCROLL_FILE="/tmp/sketchybar-music-scroll-start"
PAUSE_TIMEOUT=900   # 15 minutes
SCROLL_INTERVAL=60  # one scroll cycle per minute
SCROLL_WINDOW=20    # keep scroll_texts on long enough for one full pass

info=$(osascript <<'APP' 2>/dev/null
tell application "Music"
  if it is running then
    try
      set s to player state as string
      if s is "playing" or s is "paused" then
        return s & "|" & (name of current track) & "|" & (artist of current track)
      else
        return "stopped||"
      end if
    on error
      return "stopped||"
    end try
  else
    return "notrunning||"
  end if
end tell
APP
)

state=${info%%|*}
rest=${info#*|}
track=${rest%%|*}
artist=${rest#*|}
now=$(date +%s)

label="$track"
[ -n "$artist" ] && label="$track — $artist"

case "$state" in
  playing)
    rm -f "$STATE_FILE"

    # Toggle scroll_texts on for one cycle every SCROLL_INTERVAL seconds.
    # The state file holds the timestamp the current cycle began.
    if [ -f "$SCROLL_FILE" ]; then
      scroll_start=$(cat "$SCROLL_FILE")
    else
      scroll_start=0
    fi
    since_scroll=$(( now - scroll_start ))
    if [ "$since_scroll" -ge "$SCROLL_INTERVAL" ]; then
      echo "$now" > "$SCROLL_FILE"
      scroll_texts=on
    elif [ "$since_scroll" -lt "$SCROLL_WINDOW" ]; then
      scroll_texts=on
    else
      scroll_texts=off
    fi

    sketchybar --set "$NAME" \
      drawing=on \
      update_freq=10 \
      scroll_texts=$scroll_texts \
      icon="󰐊" \
      icon.color="$GREEN" \
      label="$label" \
      label.color="$TEXT"
    ;;

  paused)
    rm -f "$SCROLL_FILE"
    if [ ! -f "$STATE_FILE" ]; then
      echo "$now" > "$STATE_FILE"
    fi
    pause_since=$(cat "$STATE_FILE")
    elapsed=$(( now - pause_since ))
    if [ "$elapsed" -gt "$PAUSE_TIMEOUT" ]; then
      sketchybar --set "$NAME" drawing=off
      exit 0
    fi
    sketchybar --set "$NAME" \
      drawing=on \
      update_freq=10 \
      scroll_texts=off \
      icon="󰏤" \
      icon.color="$SUBTEXT" \
      label="$label" \
      label.color="$SUBTEXT"
    ;;

  *)
    # stopped / notrunning / unknown -> hide but keep pause counter
    # so that quickly resuming after a track-change blip doesn't reset
    # the timer. Counter is only cleared when state == playing.
    rm -f "$SCROLL_FILE"
    sketchybar --set "$NAME" drawing=off
    ;;
esac
