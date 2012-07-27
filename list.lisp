(in-package :yaclb)

(defun join-with (sep arg)
  (format nil (concatenate 'string "~{~A" sep "~}") arg))
