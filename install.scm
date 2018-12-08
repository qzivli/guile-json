#!/usr/bin/env guile --no-auto-compile -q
!#

(define (ensure-directory-exists dir)
  (unless (string? dir)
    (error 'ensure-directory-exists "not a string" dir))
  (if (file-exists? dir)
      (unless (file-is-directory? dir)
        (error 'ensure-directory-exists "file exists, but not a directory" dir))
      (system (format #f "mkdir --mode=0755 --parents ~s" dir))))

(define (copy-to file dir)
  (system (format #f "cp -rf ~s ~s" file dir)))

(define (main)
  (ensure-directory-exists (string-append (%site-dir) "/json"))
  (copy-to "json.scm" (%site-dir))
  (copy-to "json/" (%site-dir))
  (display "Done.\n"))

(main)
