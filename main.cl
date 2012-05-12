(ql:quickload "cl-irc")
(in-package :irc)
(defvar *connection* (connect :nickname "yaclb3" :server "irc.freenode.net"))
(read-message-loop *connection*)
(join *connection* "##the_basement")

(privmsg *connection* "##the_basement" "hello pa-pa.")

(defmacro cmd (trigger func)
  `(add-hook *connection* 'irc-privmsg-message #'(lambda (message) ,func)))

(defmacro reply (response)
  `(privmsg *connection* (first (arguments message)) ,response))

(remove-hooks *connection* 'irc-privmsg-message)

(cmd (privmsg *connection* (first (arguments message)) "words 4 u"))

(macroexpand-1 '(reply "words 4 u"))

(defun split-on-spaces (str &optional l)
  (let ((str (string-trim " " str)))
    (if (find #\Space str)
	(split-on-spaces (subseq str (position #\Space str))
			 (append l (list (concatenate 'string (loop for char across str
								 until (eq #\Space char)
								 collect char)))))
	(append l (list str)))))
		

(defun parse (str)
  (when (eq (char str 0) #\.)
    (split-on-spaces (subseq str 1))))
	

(match ".foo baz bar")

(defun my-hook (message)
     (print (arguments message)))

(add-hook *connection* 'irc-privmsg-message #'my-hook)