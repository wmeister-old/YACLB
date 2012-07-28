(in-package :yaclb)

(defun join-with (sep arg)
  (let ((output (format nil (concatenate 'string "~{~A" sep "~}") arg)))
    (subseq output 0 (- (length output) (length sep)))))
