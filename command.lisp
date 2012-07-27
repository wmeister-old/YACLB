(in-package :yaclb)

(defcmd "args" (reply (format nil "~D args = ~A" num-args args)))
(defcmd "sender" (reply (format nil "~A" (irc:source message))))

;(irc:remove-hooks *connection* 'irc::irc-privmsg-message)
