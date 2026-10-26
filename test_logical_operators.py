from e4_logical_operators import or_operator, and_operator
import pytest

def test_or():
    assert or_operator(False, True) is True
    assert or_operator(True, False) is True
    assert or_operator(True, True) is True
    assert or_operator(False, False) is False

def test_and():
    assert and_operator(False, True) is False
    assert and_operator(False, False) is False
    assert and_operator(True, False) is False
    assert and_operator(True, True) is True

if __name__ == "__main__":
    pytest.main()
