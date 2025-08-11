#!/bin/bash

battery=(
	script="$PLUGIN_DIR/battery.sh"
	icon.font="$FONT:Regular:19.0"
	# icon.color="$GREEN"
	padding_right=2
	padding_left=2
	label.drawing=on
	update_freq=120
	updates=on
)
status_bracket=(
	background.color="$BACKGROUND_1"
	background.border_color="$TRANSPARENT"
	background.border_width=2
	background.height=30
)
sketchybar --add item battery right \
	--set battery "${battery[@]}" \
		click_script="if pmset -g | grep -q 'Low Power Mode: 1'; then pmset -a lowpowermode 0; else pmset -a lowpowermode 1; fi" \
	--subscribe battery power_source_change system_woke
sketchybar --add bracket status brew vpn_alias input_alias wifi_alias volume_alias battery \
	--set status "${status_bracket[@]}"