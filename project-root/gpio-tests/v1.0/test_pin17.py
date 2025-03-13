import pytest
from gpiozero import OutputDevice
from shared.gpio_utils import validate_pin

def test_pin17_output():
    pin = OutputDevice(17)
    pin.on()
    with open("/sys/class/gpio/gpio17/value", "r") as f:
        assert f.read().strip() == "1", "Pin 17 failed to go HIGH"
    pin.off()

def test_invalid_pin():
    with pytest.raises(ValueError):
        validate_pin(99)  # Non-existent pin