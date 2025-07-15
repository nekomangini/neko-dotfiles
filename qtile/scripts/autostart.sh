#!/usr/bin/bash

picom &
dunst &
# nitrogen --restore &

# Restore Pywal wallpaper with feh
if [ -f "${HOME}/.cache/wal/wal" ]; then
  # feh --bg-scale "$(<"${HOME}/.cache/wal/wal")"
  feh --bg-fill "$(<"${HOME}/.cache/wal/wal")"
fi

# Start Polkit agent here ---
POLKIT_AGENT="/usr/libexec/polkit-kde-authentication-agent-1"
if command -v "$POLKIT_AGENT" &>/dev/null; then
  "$POLKIT_AGENT" &
  echo "KDE Polkit agent started from $POLKIT_AGENT." >>"${HOME}/.local/share/qtile_autostart_debug.log"
else
  echo "WARNING: KDE Polkit agent not found at $POLKIT_AGENT. Polkit authentication might not work." >>"${HOME}/.local/share/qtile_autostart_debug.log"
fi
# --- End Polkit agent addition ---

# --- Tmux ---
sleep 1
wezterm start -- tmux new-session -A -s main &

# --- Task Management Tools ---
sleep 1
"${HOME}/Ticktick/ticktick-6.0.30-x86_64.AppImage" &
gtk-launch appflowy &

# --- Browser ---
sleep 5
vivaldi-stable &

# --- Emacs Server ---
sleep 15
emacs --daemon="nekoserver" &

# --- Notify and Debugging ---
sleep 30 # Keep the final sleep, as some apps take a long time

EMACS_SERVER_NAME="nekoserver"
EMACS_SOCKET_PATH="$XDG_RUNTIME_DIR/emacs/${EMACS_SERVER_NAME}"

# --- BEGIN DEBUG CHECKS (or combined IF) ---
echo "--- Running final checks at $(date) ---" >>"${HOME}/.local/share/qtile_autostart_debug.log"

PGREP_WEZTERM=$(
  pgrep -x wezterm-gui >/dev/null
  echo $?
)
echo "Wezterm pgrep exit status: $PGREP_WEZTERM" >>"${HOME}/.local/share/qtile_autostart_debug.log"

PGREP_TICKTICK=$(
  pgrep -f "Ticktick/ticktick" >/dev/null
  echo $?
)
echo "Ticktick pgrep exit status: $PGREP_TICKTICK" >>"${HOME}/.local/share/qtile_autostart_debug.log"

PGREP_APPFLOWY=$(
  pgrep -f AppFlowy >/dev/null
  echo $?
)
echo "AppFlowy pgrep exit status: $PGREP_APPFLOWY" >>"${HOME}/.local/share/qtile_autostart_debug.log"

PGREP_VIVALDI=$(
  pgrep -x vivaldi-bin >/dev/null
  echo $?
)
echo "Vivaldi pgrep exit status: $PGREP_VIVALDI" >>"${HOME}/.local/share/qtile_autostart_debug.log"

PGREP_EMACS=$(
  pgrep -f "emacs --daemon=${EMACS_SERVER_NAME}" >/dev/null
  echo $?
)
CHECK_EMACS_SOCKET=$(
  [ -S "$EMACS_SOCKET_PATH" ]
  echo $?
)
echo "Emacs pgrep exit status: $PGREP_EMACS" >>"${HOME}/.local/share/qtile_autostart_debug.log"
echo "Emacs socket check exit status: $CHECK_EMACS_SOCKET" >>"${HOME}/.local/share/qtile_autostart_debug.log"

if [ "$PGREP_WEZTERM" -eq 0 ] &&
  [ "$PGREP_TICKTICK" -eq 0 ] &&
  [ "$PGREP_APPFLOWY" -eq 0 ] &&
  [ "$PGREP_VIVALDI" -eq 0 ] &&
  [ "$PGREP_EMACS" -eq 0 ] &&
  [ "$CHECK_EMACS_SOCKET" -eq 0 ]; then
  notify-send "Qtile Workspace" "All core applications initialized. Welcome Neko!" -u low
  echo "SUCCESS: All core applications are running." >>"${HOME}/.local/share/qtile_autostart_debug.log"
else
  notify-send "Qtile Workspace" "Some core applications failed to start. Check logs." -u critical
  echo "ERROR: Some core applications failed to start." >>"${HOME}/.local/share/qtile_autostart_debug.log"
fi

emacsclient -c -s "${EMACS_SERVER_NAME}"
