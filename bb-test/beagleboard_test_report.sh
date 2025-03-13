#!/bin/bash
# beagleboard_test_report.sh
# A test suite to verify USB, LAN, HDMI, GPIO (LED blink), and UART (loopback)
# This script prints a detailed report to the terminal.

set -e

echo "=========================================="
echo "       BeagleBoard Peripheral Test        "
echo "=========================================="
echo ""

##############################
# 1. Test USB Ports
##############################
echo ">>> Testing USB Ports:"
echo "Listing all detected USB devices:"
lsusb
echo ""
echo "Checking kernel USB logs:"
dmesg | grep -i usb | tail -n 10
echo "USB test completed."
echo "------------------------------------------"
echo ""

##############################
# 2. Test LAN (Ethernet)
##############################
echo ">>> Testing LAN (Ethernet):"
# Replace 'eth0' with your actual LAN interface if needed.
ETH_IFACE="eth0"
echo "Interface details for $ETH_IFACE:"
ip addr show $ETH_IFACE
echo ""
echo "Pinging 8.8.8.8 to test connectivity..."
if ping -c 4 8.8.8.8; then
    echo "Ethernet connectivity: PASS"
else
    echo "Ethernet connectivity: FAIL"
fi
echo "------------------------------------------"
echo ""

##############################
# 3. Test HDMI Connectivity
##############################
echo ">>> Testing HDMI Connectivity:"
# Using the DRM sysfs interface; adjust the device node as required.
HDMI_DEVICE="/sys/class/drm/card0-HDMI-A-1/status"
if [ -e "$HDMI_DEVICE" ]; then
    HDMI_STATUS=$(cat $HDMI_DEVICE)
    echo "HDMI status: $HDMI_STATUS"
else
    echo "HDMI device node $HDMI_DEVICE not found. Check your configuration."
fi
echo "If using X, you can run 'xrandr' for more details."
echo "------------------------------------------"
echo ""

##############################
# 4. Test GPIO (LED Blink)
##############################
echo ">>> Testing GPIO LED Blink:"
# Update GPIO_NUM with the correct GPIO number per your board's pinout.
GPIO_NUM=30
GPIO_PATH="/sys/class/gpio/gpio$GPIO_NUM"
if [ ! -d "$GPIO_PATH" ]; then
    echo "$GPIO_NUM" | sudo tee /sys/class/gpio/export > /dev/null
    sleep 0.5
fi
echo "Configuring GPIO$GPIO_NUM as output."
echo "out" | sudo tee $GPIO_PATH/direction > /dev/null

echo "Blinking LED on GPIO$GPIO_NUM..."
for i in {1..5}; do
    echo "Blink cycle $i: LED ON"
    echo 1 | sudo tee $GPIO_PATH/value > /dev/null
    sleep 0.5
    echo "Blink cycle $i: LED OFF"
    echo 0 | sudo tee $GPIO_PATH/value > /dev/null
    sleep 0.5
done
echo "GPIO LED test completed."
echo "------------------------------------------"
echo ""

##############################
# 5. Test UART TX/RX (Loopback)
##############################
echo ">>> Testing UART TX/RX (Loopback Test):"
echo "Ensure that TX and RX are physically connected with a jumper wire."
read -p "Press Enter to continue with the UART loopback test..."

# Update the UART device and settings as needed (here using /dev/ttyS1).
UART_DEVICE="/dev/ttyS1"
UART_BAUD=115200

if [ ! -e "$UART_DEVICE" ]; then
    echo "UART device $UART_DEVICE not found. Check your board configuration."
else
    echo "Configuring $UART_DEVICE to ${UART_BAUD} baud."
    stty -F $UART_DEVICE $UART_BAUD cs8 -cstopb -parenb

    TEST_MSG="UART loopback test message from BeagleBoard"
    echo "Sending message: \"$TEST_MSG\""
    echo "$TEST_MSG" > $UART_DEVICE

    echo "Waiting 2 seconds for loopback response..."
    sleep 2
    echo "Reading from UART device:"
    cat $UART_DEVICE & 
    UART_PID=$!
    sleep 3
    kill $UART_PID 2>/dev/null || true
    echo "If the loopback connection is correct, you should see the test message echoed back."
fi
echo "------------------------------------------"
echo ""

echo "=========================================="
echo "     BeagleBoard Peripheral Test Report   "
echo "              TEST SUITE COMPLETED          "
echo "=========================================="