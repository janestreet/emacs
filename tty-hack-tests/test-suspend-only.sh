#!/bin/bash
# Test suspend-tty/resume-tty without call-process-tty
cd /usr/local/home/sbaugh/src/emacs/emacs-30
rm -f /tmp/suspend-only-result.txt

# Run the expect script (expect provides PTY)
./tty-hack-tests/test-suspend-only.exp >/dev/null 2>&1

if grep -q PASS /tmp/suspend-only-result.txt 2>/dev/null; then
    echo "PASS: suspend-tty/resume-tty works"
    exit 0
else
    echo "FAIL: suspend-tty/resume-tty"
    exit 1
fi
