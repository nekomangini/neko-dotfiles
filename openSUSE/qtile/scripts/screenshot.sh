#!/bin/bash

# Take a screenshot and save it to the specified directory
# scrot -e 'mv $f /home/nekomangini/Pictures/Qtile-screenshots'

# Get the current date and time
# current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Send a notification
# notify-send "Screenshot saved to /home/nekomangini/Pictures/Qtile-screenshots/ at $current_datetime"
 
# script explanation
# scrot: This is a command-line utility for taking screenshots in Unix-like operating systems.
# 
# -e: This option allows you to specify a command to be executed after the screenshot is taken. 
#   The command should be enclosed in single quotes.
# 
# $f: Within the command specified by the -e option, $f is a special variable that scrot replaces with the filename of the screenshot. 
#   The filename is generated according to the naming pattern specified by scrot (by default, it includes the timestamp and possibly other details).
# 
# mv $f /home/nekomangini/Pictures/Screenshots/: This part of the command moves the screenshot file from its current location to the specified directory (/home/nekomangini/Pictures/Screenshots/). 
#   The $f variable is replaced by the actual filename of the screenshot.

#################################################################
# formatted output

# Create a timestamp for the filename
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Define the screenshot directory
# screenshot_dir="/home/nekomangini/Pictures/Qtile-screenshots"
screenshot_dir="/home/nekomangini/Pictures/Qtile-screenshots"

# Take a screenshot and save it to the specified directory with the timestamp in the filename
scrot "$screenshot_dir/screenshot_$timestamp.png"

# Send a notification
# install libnotify-tools if not installed
notify-send "Screenshot saved to $screenshot_dir/screenshot_$timestamp.png at $(date +"%Y-%m-%d %H:%M:%S")"
# resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
# notify-send "Screenshot taken" "Saved as screenshot_${timestamp}_${resolution}.png in $screenshot_dir"
