#!/bin/bash

sketchybar --add item ram right \
           --set ram    update_freq=2 \
                        icon=􀫦  \
                        icon.padding_right=2            \
                        background.border_width=0     \
                        background.height=1          \
                        icon.color=$YELLOW \
                        label.color=$YELLOW \
                        script="$PLUGIN_DIR/ram.sh"
