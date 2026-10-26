from e5_flow_control import fizz_buzz
import pytest

def test_fizz_buzz():
    assert fizz_buzz(1) == 1
    assert fizz_buzz(11) == 11
    assert fizz_buzz(22) == 22

    assert fizz_buzz(3) == "fizz"
    assert fizz_buzz(6) == "fizz"
    assert fizz_buzz(9) == "fizz"

    assert fizz_buzz(5) == "buzz"
    assert fizz_buzz(10) == "buzz"
    assert fizz_buzz(20) == "buzz"

    assert fizz_buzz(15) == "fizzbuzz"
    assert fizz_buzz(30) == "fizzbuzz"
    assert fizz_buzz(45) == "fizzbuzz"

    assert fizz_buzz("foo") is False

if __name__ == "__main__":
    pytest.main()
