import pytest
from e1_numbers import add, subtract, multiply, parse_int, add_and_return_2_decimal_places

def test_add():
  assert add(2, 2) == 4
  assert add(200, 10) == 210
  assert add(10, 21) == 31

def test_subtract():
  assert subtract(2, 2) == 0
  assert subtract(200, 10) == 190
  assert subtract(10, 21) == -11
  assert subtract(300, 10) == 290

def test_multiply():
  assert multiply(4, 0.1) == 0.4
  assert multiply(3, 2) == 6

def test_parse_int():
  assert parse_int("2342") == 2342
  assert parse_int("12") == 12
  with pytest.raises(ValueError):
      assert parse_int("12.4 dollars") == 12
      assert parse_int("12px") == 12
      assert parse_int("0x12") == 0

def test_add_and_return_2_decimal_places():
  result = add_and_return_2_decimal_places(1.23453, 5.37873)
  assert isinstance(result, float) and round(result, 2) == 6.61

if __name__ == "__main__":
    pytest.main()
