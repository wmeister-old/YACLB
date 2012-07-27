(in-package :yaclb)

(defun split-on-spaces (str &optional l)
  (let ((str (string-trim " " str)))
    (if (find #\Space str)
	(split-on-spaces (subseq str (position #\Space str))
			 (append l (list (concatenate 'string (loop for char across str
								 until (eq #\Space char)
								 collect char)))))
	(append l (list str)))))
