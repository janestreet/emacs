#!/bin/bash
# Test suspend-tty, call-process-tty with less, resume-tty
cd /usr/local/home/sbaugh/src/emacs/emacs-30
rm -f /tmp/suspend-callproc-result.txt

# Create a test file for less to read
echo -e "Line 1\nLine 2\nLine 3" > /tmp/test-input.txt

# Run the expect script (expect provides PTY)
./tty-hack-tests/test-suspend-with-callproc.exp >/dev/null 2>&1

# Check that less ran and exited successfully (exit code 0)
if grep -q "EXIT:0" /tmp/suspend-callproc-result.txt 2>/dev/null; then
    echo "PASS: suspend-tty + call-process-tty (less) + resume-tty works"
    exit 0
else
    echo "FAIL: suspend-tty + call-process-tty (less) + resume-tty"
    cat /tmp/suspend-callproc-result.txt 2>/dev/null
    exit 1
fi
