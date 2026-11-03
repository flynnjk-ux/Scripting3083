import subprocess

def run_shell_command(command):
    try:
        # Use subprocess to run the provided shell command
        result = 0 # run the command and capture the output

        # Print the output and any errors
        print("Command Output:")
        print() # print the output here


        # if error, print the error
        if error:
            print("Errors:")
            print() #put the error here

    except Exception as e:
        print(f"An error occurred: {e}")
