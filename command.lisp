(in-package :yaclb)

(defcmd "args" (reply (format nil "~D args = ~A" num-args args)))
(defcmd "sender" (reply (format nil "~A" (irc:source message))))
(defcmd "uname" (reply (inferior-shell:run/ss "uname -a")))

