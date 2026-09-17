#!/bin/bash

# Prompt the user to enter a directory name or path
read -p "Enter a directory name or path: " directory

# Check if the specified directory exists
if [ -d "$directory" ]; then
  # Get the current date and time
  current_date=$(date + "%Y-%m-%d")
  current_time=$(date + "%H-%M-%S")

  # Create the backup directory name by appending the current date and time
  backup_directory= "${directory}_${current_date}_${current_time}"

  # Create the backup directory
  mkdir "$backup_directory"
  
  # Copy the contents of the original directory to the backup directory
  cp -r "$directory"/. "$backup_directory"/

  # Compress the backup directory using tar
  tar -czf "$backup_directory.tar.gz" "$backup_directory"
  
  # Remove the uncompressed backup directory
  rm -r "$backup_directory"

  echo "Backup directory '$backup_directory.tar.gz' created and compressed successfully."
else
  echo "Error: Directory '$directory' does not exist."
fi
