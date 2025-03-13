import pytest
from helpers import read_pin_state

def test_pin17_turn_on():
    # Turn pin ON
    with open("/sys/class/gpio/gpio17/value", "w") as f:
        f.write("1")
    assert read_pin_state(17) == 1, "Pin 17 should be HIGH"

def test_pin17_turn_off():
    # Turn pin OFF
    with open("/sys/class/gpio/gpio17/value", "w") as f:
        f.write("0")
    assert read_pin_state(17) == 0, "Pin 17 should be LOW"