(in-package :yaclb)

(defmacro defcmd (trigger help func)
  `(progn
     (push ,help *command-help*)
     (push ,trigger *command-help*)
     (push #'(lambda (message)
		    (when (equal (concatenate 'string "." (string-downcase (string ,trigger)))
				 (string-downcase (car (split-on-spaces (second (irc:arguments message))))))
		      (let* ((args (cdr (split-on-spaces (second (irc:arguments message)))))
			     (num-args (length args))
			     (sender (irc:source message)))
			,func)))
		*commands*)))

(defmacro reply (str)
  `(irc:privmsg *connection* (car (irc:arguments message)) ,str))
