# Make scripts executable
chmod +x scripts/*.sh

# Full pipeline
./scripts/setup_gpio.sh \
&& ./scripts/run_gpio_tests.sh \
&& ./scripts/cleanup_gpio.sh