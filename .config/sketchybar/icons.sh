#!/usr/bin/env bash
# Maps an app name (as reported by yabai) to a Nerd Font glyph.
# Usage: ICON=$(icon_for "Firefox")

icon_for() {
  case "$1" in
    "Alacritty"|"iTerm"|"iTerm2"|"Terminal"|"kitty"|"WezTerm") echo  ;;
    "Firefox"|"Firefox Developer Edition"|"Firefox Nightly") echo  ;;
    "Google Chrome"|"Chromium"|"Brave Browser"|"Arc") echo  ;;
    "Safari"|"Safari Technology Preview") echo  ;;
    "DataGrip"|"IntelliJ IDEA"|"PyCharm"|"WebStorm"|"Rider"|"GoLand"|"PhpStorm"|"RubyMine"|"CLion"|"AppCode") echo  ;;
    "Music") echo  ;;
    "Spotify") echo  ;;
    "Code"|"Visual Studio Code"|"Cursor"|"VSCodium") echo  ;;
    "Slack") echo  ;;
    "Discord") echo  ;;
    "Messages") echo  ;;
    "Mail") echo  ;;
    "Notes") echo  ;;
    "Notion") echo  ;;
    "Figma") echo  ;;
    "Linear") echo 󰛙 ;;
    "Finder") echo  ;;
    "Calendar") echo  ;;
    "System Settings"|"System Preferences") echo  ;;
    "Preview") echo  ;;
    "Reminders") echo  ;;
    "Activity Monitor") echo  ;;
    "1Password"|"1Password 7 - Password Manager") echo  ;;
    "Postman") echo  ;;
    "Docker"|"Docker Desktop") echo  ;;
    "Simulator") echo  ;;
    "Xcode") echo  ;;
    "Obsidian") echo  ;;
    *) echo  ;;
  esac
}
