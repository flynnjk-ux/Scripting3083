import pytest
from e3_lists import index_of, sum_list, filter_out, append, truncate, concat, insert, square

@pytest.fixture
def test_list():
    return [3, 10, 3, 1, 2, 4, 6, 9, 2, 5, 2, 2, 3, 2, 4, 2, 4, 8, 10, 3]

def test_index_of():
    assert index_of([1, 2, 3, 3, 3, 4, 5], 3) == 2
    with pytest.raises(ValueError):
        assert index_of([1, 2, 3, 3, 3, 4, 5], 6) == -1

def test_sum():
    assert sum_list([1, 2, 3, 4, 5]) == 15
    assert sum_list([1, -1, 2, -2, 5]) == 5

def test_filter_out(test_list):
    assert filter_out(test_list, 1) == [3, 10, 3, 2, 4, 6, 9, 2, 5, 2, 2, 3, 2, 4, 2, 4, 8, 10, 3]
    assert filter_out(test_list, 2) == [3, 10, 3, 1, 4, 6, 9, 5, 3, 4, 4, 8, 10, 3]
    assert filter_out(test_list, 3) == [10, 1, 2, 4, 6, 9, 2, 5, 2, 2, 2, 4, 2, 4, 8, 10]
    assert filter_out(test_list, 4) == [3, 10, 3, 1, 2, 6, 9, 2, 5, 2, 2, 3, 2, 2, 8, 10, 3]
    assert filter_out(test_list, 5) == [3, 10, 3, 1, 2, 4, 6, 9, 2, 2, 2, 3, 2, 4, 2, 4, 8, 10, 3]
    assert filter_out(test_list, 6) == [3, 10, 3, 1, 2, 4, 9, 2, 5, 2, 2, 3, 2, 4, 2, 4, 8, 10, 3]
    assert filter_out(test_list, 7) == [3, 10, 3, 1, 2, 4, 6, 9, 2, 5, 2, 2, 3, 2, 4, 2, 4, 8, 10, 3]
    assert filter_out(test_list, 8) == [3, 10, 3, 1, 2, 4, 6, 9, 2, 5, 2, 2, 3, 2, 4, 2, 4, 10, 3]
    assert filter_out(test_list, 9) == [3, 10, 3, 1, 2, 4, 6, 2, 5, 2, 2, 3, 2, 4, 2, 4, 8, 10, 3]
    assert filter_out(test_list, 10) == [3, 3, 1, 2, 4, 6, 9, 2, 5, 2, 2, 3, 2, 4, 2, 4, 8, 3]

def test_append():
    assert append([1, 2], 3) == [1, 2, 3]

def test_truncate():
    assert truncate([1, 2, 3]) == [1, 2]

def test_concat():
    assert concat([1, 2, 3], [4, 5]) == [1, 2, 3, 4, 5]

def test_insert():
    assert insert(['Jan', 'March', 'April', 'June'], 'Feb', 1) == ['Jan', 'Feb', 'March', 'April', 'June']

def test_square():
    result = square([1, 2, 3, 4])
    assert result == [1, 4, 9, 16]

if __name__ == "__main__":
    pytest.main()
