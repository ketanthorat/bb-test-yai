#!/bin/bash

# Reset GPIO pins
PINS=(17 23 27)
for pin in "${PINS[@]}"; do
  echo $pin > /sys/class/gpio/unexport  # Deactivate
done

# Uninstall test versions
pip3 uninstall -y beagley-ai