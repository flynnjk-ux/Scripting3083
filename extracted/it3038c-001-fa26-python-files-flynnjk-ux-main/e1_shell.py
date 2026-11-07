import subprocess

def run_shell_command(command):
    try:
        # Use subprocess to run the provided shell command
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True
        ) #run the command and capture the output

        # Print the output and any errors
        print("Command Output:")
        print(result.stdout) # print the output here


        # if error, print the error
        if result.stderr:
            print("Errors:")
            print(result.stderr) #put the error here

    except Exception as e:
        print(f"An error occurred: {e}")

