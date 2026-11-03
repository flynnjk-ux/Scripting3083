import os
import pytest
from e3_directory import create_directory_and_copy_files

# Define fixtures for the source and destination directories
@pytest.fixture
def source_dir(tmpdir):
    source_dir = tmpdir.mkdir("source_dir")
    # Create a temporary file in the source directory
    source_file = source_dir.join("test_file.txt")
    source_file.write("Test content")
    return source_dir

@pytest.fixture
def destination_dir(tmpdir):
    return tmpdir.mkdir("destination_dir")

def test_create_directory_and_copy_files(capsys, source_dir, destination_dir):
    source_directory = str(source_dir)
    destination_directory = str(destination_dir)

    create_directory_and_copy_files(source_directory, destination_directory)

    captured = capsys.readouterr()
    stdout = captured.out
    stderr = captured.err

    assert "Files copied from" in stdout
    assert os.path.exists(os.path.join(destination_directory, "test_file.txt"))
    assert not stderr

if __name__ == '__main__':
    pytest.main()
