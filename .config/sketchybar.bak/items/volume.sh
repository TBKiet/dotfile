#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
                 icon.color=$MAGENTA \
                 label.color=$MAGENTA \
                 click_script="osascript -e 'set volume output muted not (output muted of (get volume settings))'" \
           --subscribe volume volume_change 