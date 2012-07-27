(in-package :yaclb)

(defun run ()
  (setq *connection* (irc:connect :nickname *nickname* :server *server*))
  (join-channels)
  (register-commands)
  (irc:read-message-loop *connection*))


