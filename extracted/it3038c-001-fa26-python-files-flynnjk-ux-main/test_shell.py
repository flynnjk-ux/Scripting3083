import subprocess
import pytest
from e1_shell import run_shell_command

@pytest.fixture
def capture_output(capsys):
    result = {}

    def run_and_capture(command):
        result['stdout'], result['stderr'] = capsys.readouterr()
        run_shell_command(command)

    result['run_and_capture'] = run_and_capture
    return result

def test_run_shell_command_success(capsys, capture_output):
    command = "echo 'Hello, World!'"
    capture_output['run_and_capture'](command)

    stdout, stderr = capsys.readouterr()
    assert "Command Output:" in stdout
    assert "Hello, World!" in stdout
    assert not stderr

def test_run_shell_command_error(capsys, capture_output):
    command = "nonexistent_command"  # A command that will result in an error
    capture_output['run_and_capture'](command)

    stdout, stderr = capsys.readouterr()
    assert "Command Output:" in stdout
    assert "Errors:" in stdout
    assert "nonexistent_command: command not found" in stdout or "not recognized as an internal or external command" in stdout or "nonexistent_command: not found" in stdout

if __name__ == '__main__':
    pytest.main()
