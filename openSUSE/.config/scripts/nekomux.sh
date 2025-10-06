#!/usr/bin/env bash

# Function to check if required dependencies are installed
create_tmux_sessions() {
  # Check if tmux is installed
  if ! command -v tmux &>/dev/null; then
    echo "Error: tmux is not installed. Please install tmux first."
    exit 1
  fi

  # Create tmux sessions in the background
  tmux new-session -d -s vim
  tmux new-session -d -s terminal
  echo "Tmux sessions 'vim' and 'terminal' created successfully."
}

# Function to attach to existing tmux sessions
attach_to_session() {
  # Check if any tmux sessions exist
  if ! tmux list-sessions &>/dev/null; then
    echo "No tmux sessions exist. Create sessions first."
    return 1
  fi

  # List available tmux sessions and allow user to select
  echo "Available tmux sessions:"
  tmux list-sessions

  # Prompt user to choose a session
  read -r -p "Enter session name to attach (vim/terminal): " session_name

  # Attach to the selected session
  case "$session_name" in
  "vim" | "terminal")
    tmux attach-session -t "$session_name"
    ;;
  *)
    echo "Invalid session name. Choose 'vim' or 'terminal'."
    ;;
  esac
}

# Function to delete a specific tmux session
delete_session() {
  # Check if any tmux sessions exist
  if ! tmux list-sessions &>/dev/null; then
    echo "No tmux sessions exist. Nothing to delete."
    return 1
  fi

  # List available tmux sessions
  echo "Available tmux sessions:"
  tmux list-sessions

  # Prompt user to choose a session to delete
  read -r -p "Enter session name to delete (vim/terminal): " session_name

  # Delete the selected session
  case "$session_name" in
  "vim" | "terminal")
    tmux kill-session -t "$session_name"
    echo "Session '$session_name' deleted successfully."
    ;;
  *)
    echo "Invalid session name. Choose 'vim' or 'terminal'."
    ;;
  esac
}

# Function to delete all tmux sessions
delete_all_sessions() {
  # Check if any tmux sessions exist
  if ! tmux list-sessions &>/dev/null; then
    echo "No tmux sessions exist. Nothing to delete."
    return 1
  fi

  # Delete all tmux sessions
  tmux kill-server
  echo "All tmux sessions deleted successfully."
}

# Main menu function to interact with tmux sessions
main_menu() {
  # Clear the screen for better readability
  clear

  # Display menu options
  echo "Tmux Session Manager"
  echo "1. Create New Tmux Sessions"
  echo "2. Attach to Active Tmux Session"
  echo "3. List Active Tmux Sessions"
  echo "4. Delete Active Tmux Session"
  echo "5. Delete All Tmux Sessions"
  echo "6. Exit"

  # Read user input
  read -r -p "Enter your choice (1-6): " choice

  # Process user choice
  case "$choice" in
  1)
    create_tmux_sessions
    sleep 2
    main_menu
    ;;
  2)
    attach_to_session
    sleep 2
    main_menu
    ;;
  3)
    echo "List of active tmux sessions:"
    tmux ls
    sleep 2
    main_menu
    ;;
  4)
    delete_session
    sleep 2
    main_menu
    ;;
  5)
    delete_all_sessions
    sleep 2
    main_menu
    ;;
  6)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid option. Please try again."
    sleep 2
    main_menu
    ;;
  esac
}

# Start the main menu
main_menu
