#!/usr/bin/env sh

# Define the wallpaper directory and temporary chooser file
WALLPAPER_DIR="/home/nekomangini/Pictures/wallpaper/"
CHOOSER_FILE="/tmp/wallpaper_choice"

# Launch Yazi in the wallpaper directory and write the selected file to CHOOSER_FILE
yazi "$WALLPAPER_DIR" --chooser-file "$CHOOSER_FILE"

# Check if a file was selected and set it as wallpaper
if [ -f "$CHOOSER_FILE" ]; then
  SELECTED_WALLPAPER=$(cat "$CHOOSER_FILE")
  if [ -n "$SELECTED_WALLPAPER" ]; then
    feh --bg-fill "$SELECTED_WALLPAPER"
  else
    echo "No file selected."
  fi
  # Clean up the temporary file
  rm -f "$CHOOSER_FILE"
else
  echo "No file was selected or chooser file wasn’t created."
fi
