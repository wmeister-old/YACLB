(in-package :yaclb)

(defun join-channels ()
  (irc:join *connection* "##the_basement"))
