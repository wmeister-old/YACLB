(ql:quickload "cl-irc")
(in-package :irc)

(defun second (l)
  (first (rest l)))

(defun split-on-spaces (str &optional l)
  (let ((str (string-trim " " str)))
    (if (find #\Space str)
	(split-on-spaces (subseq str (position #\Space str))
			 (append l (list (concatenate 'string (loop for char across str
								 until (eq #\Space char)
								 collect char)))))
	(append l (list str)))))

(defun join-with (sep arg)
  (format nil (concatenate 'string "~{~A" sep "~}") arg))

(defmacro defcmd (trigger func)
  `(add-hook *connection* 'irc-privmsg-message #'(lambda (message)
						   (when (equal (concatenate 'string "." ,trigger)
								(first (split-on-spaces (second (arguments message)))))
						     (let* ((args (cdr (split-on-spaces (second (arguments message)))))
							    (num-args (length args))
							    (sender (source message)))
						       ,func)))))

(defmacro reply (str)
  `(privmsg *connection* (first (arguments message)) ,str))

(defun reset-players ()
  (setq *player1* (make-player))
  (setq *player2* (make-player)))

(defstruct player nick)

(defvar *connection* (connect :nickname "yaclb9" :server "irc.freenode.net"))
(setq *connection* (connect :nickname "yaclb12" :server "irc.freenode.net"))
(defvar *player1* (make-player))
(defvar *player2* (make-player))

(defcmd "args" (reply (format nil "~D args = ~A" num-args args)))

(defcmd "join" 
    (when (= 0 num-args)
      (labels ((register-player-nick (player num)
		 (setf (player-nick player) sender)
		 (reply (format nil "Player #~D will be: ~A." num sender))))
	(cond ((null (player-nick *player1*))
	       (register-player-nick *player1* 1))
	      ((and (null (player-nick *player2*))
		    (not (equal sender (player-nick *player1*))))
	       (register-player-nick *player2* 2))))))
		  

(defcmd "sender" (reply (format nil "~A" (source message))))
      

(join *connection* "##the_basement")
(read-message-loop *connection*)


(remove-hooks *connection* 'irc-privmsg-message)
;(cmd (privmsg *connection* (first (arguments message)) "words 4 u"))
;(macroexpand '(cmd "foo" (reply "baz")))
;; (privmsg *connection* "##the_basement" "hello pa-pa.")
;(macroexpand '(reply "foo"))

;(defun parse (str)
;  (when (eq (char str 0) #\.)
;    (split-on-spaces (subseq str 1))))

;(match ".echo baz bar")

;(defun my-hook (message)
;     (print (arguments message)))

;(add-hook *connection* 'irc-privmsg-message #'my-hook)