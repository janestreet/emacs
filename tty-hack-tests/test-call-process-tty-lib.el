;;; test-call-process-tty-lib.el --- Shared test functions for call-process-tty

(defun test-suspend-only ()
  "Test suspend-tty and resume-tty without call-process-tty."
  (let ((tty (frame-terminal)))
    (suspend-tty tty)
    (resume-tty tty)
    (with-temp-file "/tmp/suspend-only-result.txt"
      (insert "PASS"))
    (kill-emacs 0)))

(defun test-suspend-with-callproc ()
  "Test suspend-tty, call-process-tty with less, then resume-tty."
  (let ((tty (frame-terminal)))
    (suspend-tty tty)
    (let* ((process-environment (cons "TERM=xterm" process-environment))
           (result (call-process-tty tty "less" '("/tmp/test-input.txt"))))
      (resume-tty tty)
      (with-temp-file "/tmp/suspend-callproc-result.txt"
        (insert (format "EXIT:%d" result)))
      (kill-emacs 0))))

(provide 'test-call-process-tty-lib)
;;; test-call-process-tty-lib.el ends here
