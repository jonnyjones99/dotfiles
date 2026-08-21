#!/usr/bin/env bash
# Tracks per-Claude-session status for the sketchybar 'claude' item.
# One file per session_id. Identity is the tmux PANE (session:window.pane),
# not just the session — multiple agents can share a session.
export PATH="/opt/homebrew/bin:$PATH"
STATE_DIR="$HOME/.claude/state/claude-sessions"
mkdir -p "$STATE_DIR"

input=$(cat)
event=$(printf '%s' "$input" | jq -r '.hook_event_name // empty')
sid=$(printf '%s' "$input" | jq -r '.session_id // empty')
[ -z "$sid" ] && exit 0

# Pin to THIS Claude's pane via $TMUX_PANE; without -t, tmux reports the
# focused pane, which mislabels when focus is on another pane/window.
label="no-tmux"; pane=""; sess=""
if [ -n "$TMUX_PANE" ]; then
  label=$(tmux display-message -t "$TMUX_PANE" -p '#S:#I.#P' 2>/dev/null || echo "no-tmux")
  sess=$(tmux display-message -t "$TMUX_PANE" -p '#S' 2>/dev/null || echo "")
  pane="$TMUX_PANE"
fi

case "$event" in
  SessionStart)     status="idle" ;;
  UserPromptSubmit) status="working" ;;
  Stop)             status="idle" ;;
  Notification)     status="needs" ;;
  SessionEnd)       rm -f "$STATE_DIR/$sid"; status="" ;;
  *)                status="" ;;
esac

# file format:  label \t status \t paneid \t session
[ -n "$status" ] && printf '%s\t%s\t%s\t%s\n' "$label" "$status" "$pane" "$sess" > "$STATE_DIR/$sid"
command -v sketchybar >/dev/null 2>&1 && sketchybar --trigger claude_update 2>/dev/null
exit 0
