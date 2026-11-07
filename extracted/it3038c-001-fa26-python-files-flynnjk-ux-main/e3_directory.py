import os
import shutil

def create_directory_and_copy_files(source_dir, destination_dir):
    try:
        # Create the destination directory if it doesn't exist

        os.makedirs(destination_dir,exist_ok=True)

        # This will get the names of entries in our source folder

        files_to_copy = os.listdir(source_dir)

        for file in files_to_copy:
            source_file = os.path.join(source_dir, file)
            destination_file = os.path.join(destination_dir, file)

            if os.path.isfile(source_file):
                shutil.copy2(source_file, destination_file)

        print(f"Files copied from '{source_dir}' to '{destination_dir}'.")

    except Exception as e:
        print(f"An error occurred: {e}")
