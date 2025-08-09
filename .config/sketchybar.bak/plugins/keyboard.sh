#!/bin/bash

# Detect the current keyboard layout
LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep 'KeyboardLayout Name' | cut -d '=' -f 2 | sed 's/[", ]//g')"

# Specify short layouts for English ABC and Telex
case "$LAYOUT" in
    "ABC") SHORT_LAYOUT="ABC";;
    "Telex") SHORT_LAYOUT="Telex";;
    *) SHORT_LAYOUT="Other";;  # Default for other layouts
esac

# Set the label to the short layout
sketchybar --set keyboard label="$SHORT_LAYOUT"


