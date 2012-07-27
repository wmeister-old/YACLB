
(defun set-game-state (state)
  (setq *game-state* state))

(defun new-game ()
  (setq *player1* (make-player))
  (setq *player2* (make-player))
  (set-game-state :match-making))

(defun game-state-eq (state)
  (eq *game-state* state))

(defstruct player nick)


(defvar *player1* (make-player))
(defvar *player2* (make-player))
(defvar *game-state* :match-making)
(defconstant +pokemon+ (make-array 1 :initial-contents '((:name "Testmon"))))


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

