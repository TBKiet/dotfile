#!/bin/bash

sketchybar --add item cpu right \
           --set cpu    update_freq=2 \
                        icon=􀧓  \
                        icon.padding_left=1            \
                        icon.padding_right=2            \
                        background.border_width=0     \
                        background.height=1          \
                        icon.color=$RED \
                        label.color=$RED \
                        script="$PLUGIN_DIR/cpu.sh"