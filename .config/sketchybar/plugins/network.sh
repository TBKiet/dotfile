#!/usr/bin/env sh

# Check if wdutil is available
WDUTIL_PATH="/usr/bin/wdutil"  # Typically located in /usr/bin, adjust if needed

if [ ! -x "$WDUTIL_PATH" ]; then
  sketchybar --set $NAME label="wdutil not found" icon=睊
  exit 1
fi

# Get current Wi-Fi status using wdutil
CURRENT_WIFI="$($WDUTIL_PATH status 2>/dev/null)"

# If wdutil didn't return output, handle error
if [ -z "$CURRENT_WIFI" ]; then
  sketchybar --set $NAME label="No Wi-Fi data" icon=睊
  exit 1
fi

# Extract SSID and transmission rate from wdutil output
SSID=$(echo "$CURRENT_WIFI" | awk -F': ' '/SSID/ {print $2}')
CURR_TX=$(echo "$CURRENT_WIFI" | awk -F': ' '/Tx Rate/ {print $2}')

# Handle the case when no SSID is found (disconnected)
if [ -z "$SSID" ]; then
  sketchybar --set $NAME label="Disconnected" icon=睊
  exit 0
fi

# If Tx rate is not available, show "No Tx info"
if [ -z "$CURR_TX" ]; then
  sketchybar --set $NAME label="$SSID (No Tx info)" icon=直
else
  sketchybar --set $NAME label="$SSID (${CURR_TX}Mbps)" icon=直
fi
