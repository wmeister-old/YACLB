(in-package :yaclb)

(defun join-channels ()
  (dolist (channel *channels*)
    (irc:join *connection* channel)))

(defun register-commands ()
  (dolist (command *commands*)
    (irc:add-hook *connection* 'irc::irc-privmsg-message command)))

(defun reset-commands ()
  (irc:remove-hooks *connection* 'irc::irc-privmsg-message)
  (register-commands))
