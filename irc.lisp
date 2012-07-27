(in-package :yaclb)

(defun join-channels (channels)
  (dolist (channel channels)
    (irc:join *connection* channel)))

(defun register-commands (commands)
  (dolist (command commands)
    (irc:add-hook *connection* 'irc::irc-privmsg-message command)))
