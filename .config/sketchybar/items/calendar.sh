#!/bin/bash

sketchybar --add item calendar right \
           --set calendar icon=􀧞  \
                          update_freq=30 \
                          icon.color=$ORANGE \
                          label.color=$ORANGE \
                          script="$PLUGIN_DIR/calendar.sh"