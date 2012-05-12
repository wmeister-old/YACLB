(ql:quickload "cl-irc")
(in-package :irc)
(defvar *connection* (connect :nickname "yaclb6" :server "irc.freenode.net"))
(read-message-loop *connection*)
(join *connection* "##the_basement")

(privmsg *connection* "##the_basement" "hello pa-pa.")

(defmacro cmd (trigger func)
  `(add-hook *connection* 'irc-privmsg-message #'(lambda (message)
						   (print (concatenate 'string "." ,trigger))
						   (print (first (split-on-spaces (second (arguments message)))))
						   (when (equal (concatenate 'string "." ,trigger)
								(first (split-on-spaces (second (arguments message)))))
						     ,func))))

(defmacro reply (str)
  `(privmsg *connection* (first (arguments message)) ,str))

(defun second (l)
  (first (rest l)))


(remove-hooks *connection* 'irc-privmsg-message)
(cmd "echo" (reply (second (arguments message))))


;(cmd (privmsg *connection* (first (arguments message)) "words 4 u"))
;(macroexpand '(cmd "foo" (reply "baz")))
(macroexpand '(reply "foo"))


(defun split-on-spaces (str &optional l)
  (let ((str (string-trim " " str)))
    (if (find #\Space str)
	(split-on-spaces (subseq str (position #\Space str))
			 (append l (list (concatenate 'string (loop for char across str
								 until (eq #\Space char)
								 collect char)))))
	(append l (list str)))))
		

(defun parse (str)
  (when (eql (char str 0) #\.)
    (split-on-spaces (subseq str 1))))
	

(match ".echo baz bar")

(defun my-hook (message)
     (print (arguments message)))

(add-hook *connection* 'irc-privmsg-message #'my-hook)