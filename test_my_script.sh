#!/bin/bash

# Function to compare actual output with expected output
function assert_equal() {
    local actual="$1"
    local expected="$2"
    if [ "$actual" != "$expected" ]; then
        echo "Test Failed!"
        echo "Expected: $expected"
        echo "Actual:   $actual"
        exit 1
    fi
}

# Test case 1: Help information
echo "Test case 1: Help information"
actual_output=$(./my_script.sh -h)
expected_output=$(cat <<- EOM
Usage: ./my_script.sh -f <filename> -o <output_dir> -t <type>
Options:
  -f <filename>: Specify the input filename.
  -o <output_dir>: Specify the output directory where the results will be stored.
  -t <type>: Specify the type of action to perform. Supported types are 'process' and 'analyze'.
  -h: Display this help information.
EOM
)
assert_equal "$actual_output" "$expected_output"
echo "Test Passed!"
echo ""

# Test case 2: Missing arguments
echo "Test case 2: Missing arguments"
actual_output=$(./my_script.sh)
expected_output=$(cat <<- EOM
Usage: ./my_script.sh -f <filename> -o <output_dir> -t <type>
Options:
  -f <filename>: Specify the input filename.
  -o <output_dir>: Specify the output directory where the results will be stored.
  -t <type>: Specify the type of action to perform. Supported types are 'process' and 'analyze'.
  -h: Display this help information.
EOM
)
assert_equal "$actual_output" "$expected_output"
echo "Test Passed!"
echo ""

# Test case 3: Invalid option
echo "Test case 3: Invalid option"
actual_output=$(./my_script.sh -x)
expected_output=$(cat <<- EOM
Invalid option: -x
Usage: ./my_script.sh -f <filename> -o <output_dir> -t <type>
Options:
  -f <filename>: Specify the input filename.
  -o <output_dir>: Specify the output directory where the results will be stored.
  -t <type>: Specify the type of action to perform. Supported types are 'process' and 'analyze'.
  -h: Display this help information.
EOM
)
assert_equal "$actual_output" "$expected_output"
echo "Test Passed!"
echo ""

# Test case 4: Missing required options
echo "Test case 4: Missing required options"
actual_output=$(./my_script.sh -f input.txt)
expected_output=$(cat <<- EOM
Error: Missing required options.
Usage: ./my_script.sh -f <filename> -o <output_dir> -t <type>
Options:
  -f <filename>: Specify the input filename.
  -o <output_dir>: Specify the output directory where the results will be stored.
  -t <type>: Specify the type of action to perform. Supported types are 'process' and 'analyze'.
  -h: Display this help information.
EOM
)
assert_equal "$actual_output" "$expected_output"
echo "Test Passed!"
echo ""

# Test case 5: Invalid action type
echo "Test case 5: Invalid action type"
actual_output=$(./my_script.sh -f input.txt -o output_dir -t invalid)
expected_output="Error: Invalid action type. Supported types are 'process' and 'analyze'."
assert_equal "$actual_output" "$expected_output"
echo "Test Passed!"
echo ""

# Test case 6: Non-existent input file
echo "Test case 6: Non-existent input file"
actual_output=$(./my_script.sh -f non_existent.txt -o output_dir -t process)
expected_output="Error: Input file 'non_existent.txt' does not exist or is not a regular file."
assert_equal "$actual_output" "$expected_output"
echo "Test Passed!"
echo ""

# Test case 7: Non-existent output directory
echo "Test case 7: Non-existent output directory"
touch input.txt
actual_output=$(./my_script.sh -f input.txt -o non_existent_dir -t analyze)
expected_output="Error: Output directory 'non_existent_dir' does not exist."
assert_equal "$actual_output" "$expected_output"
rm input.txt
echo "Test Passed!"
echo ""

# Test case 8: Valid input and output, Process action
echo "Test case 8: Valid input and output, Process action"
touch input.txt
mkdir -p output_dir
actual_output=$(./my_script.sh -f input.txt -o output_dir -t process)
expected_output="Processing task will be performed on 'input.txt' and the results will be stored in 'output_dir'."
assert_equal "$actual_output" "$expected_output"
rm input.txt
rm -r output_dir
echo "Test Passed!"
echo ""

# Test case 9: Valid input and output, Analyze action
echo "Test case 9: Valid input and output, Analyze action"
touch input.txt
mkdir -p output_dir
actual_output=$(./my_script.sh -f input.txt -o output_dir -t analyze)
expected_output="Analysis will be performed on 'input.txt' and the report will be stored in 'output_dir'."
assert_equal "$actual_output" "$expected_output"
rm input.txt
rm -r output_dir
echo "Test Passed!"
echo ""

# Test case 10: name of script referenced dynamically
echo "Test case 10: name of script referenced dynamically"
cp my_script.sh my_script2.sh
actual_output=$(./my_script2.sh -h)
expected_output=$(cat <<- EOM
Usage: ./my_script2.sh -f <filename> -o <output_dir> -t <type>
Options:
  -f <filename>: Specify the input filename.
  -o <output_dir>: Specify the output directory where the results will be stored.
  -t <type>: Specify the type of action to perform. Supported types are 'process' and 'analyze'.
  -h: Display this help information.
EOM
)
assert_equal "$actual_output" "$expected_output"
echo "Test Passed!"
echo ""