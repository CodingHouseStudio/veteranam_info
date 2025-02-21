#!/bin/bash

run_flutter_test() {
    local total_tests=${#TESTS[@]}
    local current_test_number=1
    local failed_tests=0  # Counter for failed tests

    for test_name in "$@"
    do
        echo "Running test: $test_name #$current_test_number out of $total_tests"
        # Run the test and store output in a variable
        output=$(flutter drive \
            --flavor development \
            --driver=test_driver/integration_test.dart \
            --target=integration_test/"$test_name"_test.dart \
            -d chrome\
            --web-port=8080\
            --dart-define=FLAVOUR=development\
            --dart-define=ROLE=user\
            --dart-define-from-file=.env_dev.json\
            --flavor=development)

        # Check if the test passed or failed and print the relevant message
        if echo "$output" | grep -q "All tests passed"; then
            echo "Test #$current_test_number: $test_name PASSED"
        else
            echo "Test #$current_test_number: $test_name FAILED"
            echo "$output" | grep -A 5 -B 5 "EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK" # Adjust this line as needed
            ((failed_tests++))  # Increment the failed tests counter
        fi
        ((current_test_number++))
    done

    # Return 1 if any test failed, otherwise return 0
    if [ $failed_tests -gt 0 ]; then
        return 1
    else
        return 0
    fi
}

# List of tests to run
TESTS=(
    "email_dialog"
    "discount_screen"
)

run_flutter_test "${TESTS[@]}"
exit $?  # Exit with the status code from run_flutter_test
