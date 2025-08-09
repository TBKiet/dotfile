#!/bin/bash

sketchybar --add item wifi right \
           --set volume script="$PLUGIN_DIR/wifi.sh" \
           --subscribe wifi wifi_change                        