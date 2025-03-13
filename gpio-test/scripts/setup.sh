#!/bin/bash

# Enable GPIO access
sudo chmod ugo+rw /sys/class/gpio/export
sudo chmod ugo+rw /sys/class/gpio/unexport

# Install basic tools
sudo apt-get update
sudo apt-get install -y python3-gpiozero

# Activate pins to test (17 and 23 in this example)
echo 17 > /sys/class/gpio/export
echo 23 > /sys/class/gpio/export

# Set pin directions
echo out > /sys/class/gpio/gpio17/direction
echo out > /sys/class/gpio/gpio23/direction

# Allow non-root access
sudo chmod 666 /sys/class/gpio/gpio17/value
sudo chmod 666 /sys/class/gpio/gpio23/value