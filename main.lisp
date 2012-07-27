(in-package :yaclb)

(defun run ()
  (setq *connection* (irc:connect :nickname *nickname* :server *server*))
  (join-channels *channels*)
  (register-commands *commands*)
  (irc:read-message-loop *connection*))


