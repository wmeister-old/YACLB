(in-package :yaclb)

(defvar *connection* nil)
(defvar *channels* '("##the_basement"))
(defvar *nickname* "yaclb")
(defvar *server* "irc.freenode.net")
(defvar *commands* nil)
(defvar *command-help* nil)

(clouchdb:set-connection :name "yaclb")
