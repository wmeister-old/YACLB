(ql:quickload "cl-irc")

(defun second (l)
  (car (cdr l)))

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
  `(irc:add-hook *connection* 'irc::irc-privmsg-message #'(lambda (message)
						   (when (equal (concatenate 'string "." ,trigger)
								(car (split-on-spaces (second (irc:arguments message)))))
						     (let* ((args (cdr (split-on-spaces (second (irc:arguments message)))))
							    (num-args (length args))
							    (sender (irc:source message)))
						       ,func)))))

(defmacro reply (str)
  `(irc:privmsg *connection* (car (irc:arguments message)) ,str))

(defun set-game-state (state)
  (setq *game-state* state))

(defun new-game ()
  (setq *player1* (make-player))
  (setq *player2* (make-player))
  (set-game-state :match-making))

(defun game-state-eq (state)
  (eq *game-state* state))

(defstruct player nick)

(defvar *connection* (irc:connect :nickname "yaclb9" :server "irc.freenode.net"))
;(setq *connection* (connect :nickname "yaclb12" :server "irc.freenode.net"))
(defvar *player1* (make-player))
(defvar *player2* (make-player))
(defvar *game-state* :match-making)
(defconstant +pokemon+ (make-array 1 :initial-contents '((:name "Testmon"))))

(defcmd "args" (reply (format nil "~D args = ~A" num-args args)))

(defcmd "join" 
    (when (and (= 0 num-args)
	       (game-state-eq :match-making))
      (labels ((register-player-nick (player num)
		 (setf (player-nick player) sender)
		 (reply (format nil "Player #~D will be: ~A." num sender))))
	(cond ((player-nick *player1*)
	       (register-player-nick *player1* 1))
	      ((and (player-nick *player2*)
		    (not (equal sender (player-nick *player1*))))
	       (progn (register-player-nick *player2* 2)
		      (set-game-state :team-selection)))))))

(defcmd "choose"
    (when (and (= 1 num-args)
	       (game-state-eq :team-selection)) ;; TODO check for sender in *player1/2*, also ensure they havnt chosen yet
      (let ((pokemon-id (parse-integer (car args) :junk-allowed t)))
	(unless pokemon-id ;; do i need to call null?
	  (when (array-in-bounds-p +pokemon+ pokemon-id)
	    (let ((pokemon-name (getf (aref +pokemon+ pokemon-id) :name))) ;; TODO set the selection and update the game state if both players have chosen
	      (reply (format nil "~A choose ~A." sender pokemon-name))))))))

(defcmd "sender" (reply (format nil "~A" (irc:source message))))

(irc:join *connection* "##the_basement")
(irc:join *connection* "##the_basement2")
(irc:read-message-loop *connection*)

;(irc:remove-hooks *connection* 'irc::irc-privmsg-message)
