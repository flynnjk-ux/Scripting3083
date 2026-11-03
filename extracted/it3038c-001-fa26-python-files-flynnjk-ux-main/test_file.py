import pytest
from e2_file import count_lines_words_in_file

# Define a fixture to capture stdout
@pytest.fixture
def capture_output(capsys):
    result = {}

    def run_and_capture(file_path):
        result['stdout'], result['stderr'] = capsys.readouterr()
        count_lines_words_in_file(file_path)

    result['run_and_capture'] = run_and_capture
    return result

def test_count_lines_words_existing_file(capsys, capture_output):
    # Create a temporary file with known content for testing
    file_content = "This is a test.\nThis is another test."
    with open('test_file.txt', 'w') as file:
        file.write(file_content)

    file_path = 'test_file.txt'
    capture_output['run_and_capture'](file_path)

    stdout, stderr = capsys.readouterr()

    assert f"Number of lines: 2" in stdout
    assert f"Number of words: 8" in stdout
    assert not stderr

def test_count_lines_words_nonexistent_file(capsys, capture_output):
    file_path = 'nonexistent_file.txt'  # A file that doesn't exist
    capture_output['run_and_capture'](file_path)

    stdout, stderr = capsys.readouterr()

    assert f"The file '{file_path}' does not exist." in stdout
    assert not stderr

if __name__ == '__main__':
    pytest.main()
