import os

def count_lines_words_in_file(file_path):
    try:
        # Check if the file exists
        if os.path.exists(file_path):
            # Open the file in read mode
            with open(file_path, "r", encoding="utf-8") as file:
                content = file.read()
                lines = content.splitlines()
                words = content.split()
                print(f"Number of lines: {len(lines)}")
                print(f"Number of words: {len(words)}")
        else:
            print(f"The file '{file_path}' does not exist.")

    except Exception as e:
        print(f"An error occurred: {e}")
