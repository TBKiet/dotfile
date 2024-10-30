#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
                 icon.color=$MAGENTA \
                 label.color=$MAGENTA \
           --subscribe volume volume_change 