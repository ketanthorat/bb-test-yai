#!/bin/bash

# Run all tests and generate HTML report
pytest tests/ \
  --html=reports/report.html \
  --self-contained-html

# Check if tests failed
if grep "failed" reports/report.html; then
  echo "GPIO Regression Failed!"
  exit 1
else
  echo "All GPIO Tests Passed!"
fi