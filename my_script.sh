#!/bin/bash

# Function to display script usage/help information
function display_usage() {
  # hint: you will have multiple echo statements here
  echo "Usage: $0 -f filename -o output_dir -a action"
   echo "-f    input filename"
    echo "-o    output directory"
    echo "-a    action to perform"
}

# Check if no arguments are provided.
# If so, display usage information and exit
if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi


# Initialize variables (you don't need to change this part)
filename=""
output_dir=""
action=""

# Process command-line options and arguments
while getopts "f:0:t:h" option; do
  case $option in
        # option f
            filename="$OPTARG"
            ;;

        # option o
            output_dir="$OPTARG"
            ;;
        # option t
            action="$OPTARG"
            ;;
        # option h
         display_usage
            exit 0
            ;;
            # display usage and exit
        # any other option
            echo "Invalid option: -a"
            # display usage and exit
        # no argument
            echo "Option -a requires an argument."
            # display usage and exit

# Check if all required switches are provided (f, o, t are required. since each of these sets a variable, you can use those variables to know if the option was provided)
  if [ -z "$filename" ] || [ -z "$output_dir" ] || [ -z "$action" ]; then
    echo "Error: Missing required options."
    display_usage
    exit 1
fi
    
    # display usage and exit

# Check if the -t switch has a valid argument
   if [ "$action" != "process" ] && [ "$action" != "analyze" ]; then
    echo "Error: Invalid action type. Supported types are 'process' and 'analyze'."
    exit 1
fi
    # exit

# Check if the specified input filename exists and is a regular file
 if [ ! -f "$filename" ]; then
    echo "Error: Input file '$filename' does not exist or is not a regular file."
    exit 1
fi
    # exit

# Check if the specified output directory exists and is a directory
if [ ! -d "$output_dir" ]; then
    echo "Error: Output directory '$output_dir' does not exist."
    exit 1
fi
    # exit
# Perform the selected action based on the user input
if [ "$action" = "process" ]; then
    echo "Processing task will be performed on '$filename' and the results will be stored in '$output_dir'."
elif [ "$action" = "analyze" ]; then
    echo "Analysis will be performed on '$filename' and the report will be stored in '$output_dir'."
fi
# if action is process
    # You don't actually need to do anything here, just echo the message
    echo "Processing task will be performed on '$filename' and the results will be stored in '$output_dir'."
# else if action is analyze
    # You don't actually need to do anything here, just echo the message
    echo "Analysis will be performed on '$filename' and the report will be stored in '$output_dir'."
