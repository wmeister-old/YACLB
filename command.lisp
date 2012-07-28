(in-package :yaclb)

(defcmd :args "show the arguments received"
  (reply (format nil "~D args = ~A" num-args args)))

(defcmd :sender "reply with the sender of the command"
    (reply (format nil "~A" (irc:source message))))

(defcmd :uname "show the uname of the host"
  (reply (inferior-shell:run/ss "uname -a")))

(defcmd :uptime "show the uptime of the host"
  (reply (inferior-shell:run/ss "uptime")))

(defcmd :dbver "show the CouchDB version"
  (reply (format nil "CouchDB v~A" (clouchdb:document-property :|version| (clouchdb:get-couchdb-info)))))

(defcmd :dbinfo "show information about the current database"
    (let ((info (clouchdb:get-db-info)))
      (reply (join-with "; " (map 'list
				  #'(lambda (prop) 
				      (if (clouchdb:document-property prop info)
					  (format nil "~A=~A" prop (clouchdb:document-property prop info))
					  prop))
				  (map 'list 'car info))))))

(defcmd :help "show the usage of a command"
  (let ((help (getf *command-help* (intern (string-upcase (car args)) :keyword))))
    (when help (reply help))))
