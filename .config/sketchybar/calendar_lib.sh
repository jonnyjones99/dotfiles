#!/usr/bin/env bash
# Shared helpers for calendar widgets. Sourced by event_pill.sh and date.sh.

# Fetch raw events between two dates in icalBuddy's clean format:
#   YYYY-MM-DD at HH:MM - HH:MM|Title          (timed)
#   YYYY-MM-DD|Title                            (all-day)
fetch_events_raw() {
  local from="$1" to="$2"
  icalBuddy \
    -nc -npn -nrd \
    -iep "title,datetime" \
    -po "datetime,title" \
    -ps "/|/" \
    -b "" \
    -tf "%H:%M" \
    -df "%Y-%m-%d" \
    "eventsFrom:$from" "to:$to" 2>/dev/null
}

# Return the next timed event (today only) as: "EPOCH|HH:MM|Title"
# Lines are sorted by start time; we filter out events already past.
next_event_today() {
  local today now_epoch line date_part rest start_hm title start_epoch
  today=$(date '+%Y-%m-%d')
  now_epoch=$(date '+%s')

  fetch_events_raw "$today" "$today" | while IFS='|' read -r datetime title; do
    # Skip all-day events (no "at" in datetime).
    case "$datetime" in
      *" at "*) ;;
      *) continue ;;
    esac
    date_part=${datetime%% at *}
    rest=${datetime#* at }
    start_hm=${rest%% - *}
    start_epoch=$(date -j -f "%Y-%m-%d %H:%M" "$date_part $start_hm" "+%s" 2>/dev/null)
    [ -z "$start_epoch" ] && continue
    if [ "$start_epoch" -ge "$now_epoch" ]; then
      printf '%s|%s|%s\n' "$start_epoch" "$start_hm" "$title"
      break
    fi
  done
}

# Pretty-print "in Xmin" / "in Xh Ymin" for a future epoch.
human_until() {
  local target now diff mins hrs
  target="$1"
  now=$(date '+%s')
  diff=$(( target - now ))
  if [ "$diff" -le 0 ]; then echo "now"; return; fi
  mins=$(( diff / 60 ))
  if [ "$mins" -lt 60 ]; then
    echo "in ${mins}min"
  else
    hrs=$(( mins / 60 ))
    mins=$(( mins % 60 ))
    echo "in ${hrs}h ${mins}min"
  fi
}
