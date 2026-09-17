#!/bin/bash

# Define the location of the backup script
backup_script="./2-backup-file.sh"

# Function to run a test
run_test() {
  local filename=$1
  local expected_output=$2

  echo "Running test: $filename"

  # Execute the backup script and capture the output
  actual_output=$($backup_script <<<"$filename")
  backup_filename=$(echo "$actual_output" | grep -oE "'.+'" | tr -d "'")

  # Display the test result
  if [[ $actual_output == *$expected_output* ]]; then
    # Check if the file exists
    if [ -f "$filename" ] && [ ! -f "$backup_filename" ]; then
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
run_test "README.md" "Backup file 'README_*.md.tar.gz' created and compressed successfully."
run_test "nonexistent.txt" "Error: File 'nonexistent.txt' does not exist."
