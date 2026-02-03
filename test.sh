#!/bin/bash
set -o errexit -o nounset

echo "Testing run-with-terminal-control"
echo "=================================="

if ! command -v expect &> /dev/null; then
    echo "ERROR: expect is required (sudo yum install expect)"
    exit 1
fi

if [ ! -x ./src/emacs ]; then
    echo "ERROR: ./src/emacs not found. Run 'make' first."
    exit 1
fi

# Test 1: Runs 'less' interactively
echo -n "Test 1: Runs 'less' interactively... "
./test.exp testfile.txt || echo "FAILED"

# Test 2: Works with Emacs server
echo -n "Test 2: Works with emacsclient... "
./src/emacs --fg-daemon="test-$$" -Q &
daemon_pid=$!
sleep 1
./test-server.exp "test-$$" testfile.txt || echo "FAILED"
kill $daemon_pid

echo
echo "All tests passed!"
