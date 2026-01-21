;;; test-call-process-tty-manual.el --- Manual test for call-process-tty with suspend

(require 'test-call-process-tty-lib)

(defun run-less-on-file (file)
  "Run less on FILE on the current terminal - for manual testing."
  (interactive "fFile to view with less: ")
  (let ((tty (frame-terminal))
        (process-environment (cons "TERM=xterm" process-environment)))
    (unless tty
      (error "No terminal for current frame"))
    (suspend-tty tty)
    (unwind-protect
        (progn
          (message "Running less on %s..." file)
          (call-process-tty tty "less" (list (expand-file-name file))))
      (resume-tty tty))))

(provide 'test-call-process-tty-manual)
;;; test-call-process-tty-manual.el ends here
