#!/bin/bash

VERSIONS=("1.0" "2.0")  # Test these versions

for version in "${VERSIONS[@]}"; do
  echo "Testing BeagleY-AI version $version"
  
  # Install specific version
  pip3 install --force-reinstall beagley-ai==$version
  
  # Run tests for this version
  pytest gpio-tests/$version/ \
    --html=reports/${version}_results.html \
    --log-file=reports/${version}_log.txt
  
  # Check for regression
  if grep "FAILED" reports/${version}_log.txt; then
    echo "Regression in version $version!"
    exit 1
  fi
done