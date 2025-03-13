#!/bin/bash

# Enable GPIO access on BeagleBoard
echo "Setting up GPIO permissions..."
sudo chmod ugo+rw /sys/class/gpio/export
sudo chmod ugo+rw /sys/class/gpio/unexport

# Install dependencies
sudo apt-get install -y python3-gpiozero libgpiod-dev
pip3 install beagley-ai==$VERSION  # Version will be passed as argument

# List GPIO pins to test
PINS=(17 23 27)  # Pins to test
for pin in "${PINS[@]}"; do
  echo $pin > /sys/class/gpio/export  # Activate pin
  chmod 666 /sys/class/gpio/gpio$pin/value  # Allow read/write
done