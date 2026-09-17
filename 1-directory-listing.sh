#!/bin/bash

# Prompt the user to enter a directory path
read -p "Enter the directory name or path: " directory

# Check if the directory exists
  if [ -d "$directory" ]; then
  # If
  echo "Directory exists. Listing files and subdirectories:"

  # List all files and subdirectories in the specified directory
  ls "$directory"

# else the directory does not exist
else
  echo "Error: Directory does not exist."

fi
