(in-package :yaclb)

(defun run ()
  (join-channels)
  (irc:read-message-loop *connection*))


