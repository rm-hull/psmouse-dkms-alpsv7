#!/usr/bin/env bash

command -v synclient >/dev/null 2>&1 || { echo "synclient is required but it's not installed. Aborting."; exit 1; }
command -v xinput >/dev/null 2>&1 || { echo "xinput is required but it's not installed. Aborting."; exit 1; }

# Settings for the new T450p trackpoint
xinput --set-prop "DualPoint Stick" "Device Accel Profile" 0
xinput set-ptr-feedback 13 10 12 1
xinput --set-prop "DualPoint Stick" "Device Accel Constant Deceleration" 0.6
xinput --set-prop "DualPoint Stick" "Device Accel Adaptive Deceleration" 2.4
xinput --set-prop "DualPoint Stick" "Device Accel Velocity Scaling" 20.0

# Alternative settings A
#xinput set-ptr-feedback 13 2 31 10
#xinput --set-prop "DualPoint Stick" "Device Accel Profile" 2
#xinput --set-prop "DualPoint Stick" "Device Accel Constant Deceleration" 0.9
#xinput --set-prop "DualPoint Stick" "Device Accel Adaptive Deceleration" 2.2
#xinput --set-prop "DualPoint Stick" "Device Accel Velocity Scaling" 14.0

# Alternative settings B 
#xinput --set-prop "DualPoint Stick" "Device Accel Profile" 0
#xinput set-ptr-feedback 13 1 14 1
#xinput --set-prop "DualPoint Stick" "Device Accel Constant Deceleration" 1.0
#xinput --set-prop "DualPoint Stick" "Device Accel Adaptive Deceleration" 1.8
#xinput --set-prop "DualPoint Stick" "Device Accel Velocity Scaling" 16.0

# Set certain properties for a better touchpad experience
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient ClickFinger1=1
synclient ClickFinger2=3
synclient ClickFinger3=2
synclient HorizHysteresis=30 
synclient VertHysteresis=30
synclient FingerHigh=40 #47
synclient FingerLow=35 #47
synclient PalmMinWidth=5
synclient PalmDetect=1

