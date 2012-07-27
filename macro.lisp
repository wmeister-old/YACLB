(in-package :yaclb)

(defmacro defcmd (trigger func)
  `(irc:add-hook *connection* 'irc::irc-privmsg-message #'(lambda (message)
						   (when (equal (concatenate 'string "." ,trigger)
								(car (split-on-spaces (second (irc:arguments message)))))
						     (let* ((args (cdr (split-on-spaces (second (irc:arguments message)))))
							    (num-args (length args))
							    (sender (irc:source message)))
						       ,func)))))

(defmacro reply (str)
  `(irc:privmsg *connection* (car (irc:arguments message)) ,str))
