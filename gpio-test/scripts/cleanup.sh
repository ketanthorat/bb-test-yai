#!/bin/bash

# Reset pins to safe state
echo 0 > /sys/class/gpio/gpio17/value
echo 0 > /sys/class/gpio/gpio23/value

# Unexport pins
echo 17 > /sys/class/gpio/unexport
echo 23 > /sys/class/gpio/unexport