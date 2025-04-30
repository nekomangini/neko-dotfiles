#!/usr/bin/env sh

# Define the wallpaper directory and temporary chooser file
WALLPAPER_DIR="/home/nekomangini/Pictures/wallpaper/"
CHOOSER_FILE="/tmp/wallpaper_choice"

# Launch Yazi in the wallpaper directory and write the selected file to CHOOSER_FILE
yazi "$WALLPAPER_DIR" --chooser-file "$CHOOSER_FILE"

# Check if a file was selected
if [ -f "$CHOOSER_FILE" ]; then
  SELECTED_WALLPAPER=$(cat "$CHOOSER_FILE")
  if [ -n "$SELECTED_WALLPAPER" ]; then
    # Set wallpaper with feh
    feh --bg-fill "$SELECTED_WALLPAPER"
    # Generate Pywal colors
    wal -i "$SELECTED_WALLPAPER"
    # Reload Qtile to apply new colors if pywal theme is active
    qtile cmd-obj -o cmd -f reload_config
  else
    echo "No file selected."
  fi
  # Clean up the temporary file
  rm -f "$CHOOSER_FILE"
else
  echo "No file was selected or chooser file wasn’t created."
fi
