#!/bin/bash

# Run the tests with coverage and concurrency
very_good test --concurrency=$(sysctl -n hw.logicalcpu) --recursive --optimization --coverage --test-randomize-ordering-seed=random

# Generate the initial HTML coverage report
genhtml coverage/lcov.info -o coverage/html

# Define the exclusion file
# EXCLUDE_FILE='coverage_excludes.txt'

# Exclude specific files and directories from the coverage report
lcov --remove coverage/lcov.info $(cat coverage_excludes.txt) --output-file coverage/lcov.info

# Generate the final HTML coverage report after exclusions
genhtml coverage/lcov.info -o coverage/html

# Open the final HTML coverage report
open coverage/html/index.html
