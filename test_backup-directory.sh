#!/bin/bash

# Define the location of the backup script
backup_script="./3-backup-directory.sh"

# Function to run a test
run_test() {
  local directory=$1
  local expected_output=$2

  echo "Running test: $directory"

  # Execute the backup script and capture the output
  actual_output=$($backup_script <<<"$directory")
  backup_filename=$(echo "$actual_output" | grep -oE "'.+'" | tr -d "'")

  # Display the test result
  if [[ $actual_output == *$expected_output* ]]; then
    # Check if the directory exists
    if [ -d "$directory" ] && [ ! -f "$backup_filename" ]; then
      echo "Error: File '$backup_filename' does not exist."
      echo "Result: FAILED"
      echo "------------------------"
      exit 1
    fi

    echo "Result: PASSED"
  else
    echo "Result: FAILED"
    echo "Expected: $expected_output"
    echo "Actual: $actual_output"
    exit 1
  fi

  echo "------------------------"
}

# Test cases
run_test ".vscode" "Backup directory '.vscode_*.tar.gz' created and compressed successfully."
run_test "nonexistent" "Error: Directory 'nonexistent' does not exist."
