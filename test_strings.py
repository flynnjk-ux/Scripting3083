from e2_strings import reverse_string, capitalize, split_string
import pytest

def test_reverse_string():
    assert reverse_string('abc') == 'cba'
    assert reverse_string('sretcarahc fo gnirts a ma i') == 'i am a string of characters'
    assert reverse_string('amanaP :lanac a ,nalp a ,nam A') == 'A man, a plan, a canal: Panama'

def test_capitalize():
    assert capitalize('this is scripting languages') == 'THIS IS SCRIPTING LANGUAGES'

def test_split_string():
    assert split_string('Jane,Doe,21') == ['Jane', 'Doe', '21']
    assert split_string('Jane-Doe-21', '-') == ['Jane', 'Doe', '21']

if __name__ == "__main__":
    pytest.main()
