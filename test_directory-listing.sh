#!/bin/bash

# Define the path to the directory_listing.sh script
directory_listing_script="./1-directory-listing.sh"

# Define an array of test directory paths
test_directories=(
    "./"
    "/path/to/nonexistent/directory"
    "./.vscode"
)

# Define an array of expected outputs corresponding to the test directories
expected_outputs=(
    "Directory exists. Listing files and subdirectories:"
    "Error: Directory does not exist."
    "Directory exists. Listing files and subdirectories:"
)

# Define an array of expected files in each test directory
expected_files=(
    "1-directory-listing.sh
    2-backup-file.sh
    3-backup-directory.sh
    README.md
    test_backup-directory.sh
    test_backup-file.sh
    test_directory-listing.sh"
    ""
    "settings.json"
)

# Variable to track if any test failed
tests_failed=0

# Perform the tests
for ((i = 0; i < ${#test_directories[@]}; i++)); do
    directory="${test_directories[$i]}"
    expected_output="${expected_outputs[$i]}"
    expected_files="${expected_files[$i]}"

    echo "Testing directory: $directory"
    echo "---------------------"

    # Run the directory_listing.sh script with the current test directory
    output=$(bash "$directory_listing_script" <<< "$directory")

    # Verify the output
    if [[ "$output" == "$expected_output"* ]]; then
        echo "Test Passed: Output is correct!"
    else
        echo "Test Failed: Output is incorrect."
        echo "Expected Output: $expected_output"
        echo "Actual Output: $output"
        tests_failed=1
    fi

    # Validate the files in the directory
    if [[ -n "$expected_files" ]]; then
        IFS=$'\n' read -r -a expected_files_array <<< "$expected_files"
        missing_files=0
        for file in "${expected_files_array[@]}"; do
            if [[ ! -e "$directory/$file" ]]; then
                missing_files=1
                break
            fi
        done

        if [[ $missing_files -eq 0 ]]; then
            echo "Test Passed: All expected files found!"
        else
            echo "Test Failed: Missing files!"
            echo "Expected Files: ${expected_files_array[*]}"
            tests_failed=1
        fi
    else
        if [[ "$output" != *"No files found"* && "$output" != *"Files: "* && "$output" != "Error: Directory does not exist." ]]; then
            echo "Test Failed: Unexpected files found!"
            tests_failed=1
        fi
    fi

    echo "====================="
    echo
done

# Exit with non-zero status if any tests failed
if [[ $tests_failed -eq 1 ]]; then
    exit 1
fi
