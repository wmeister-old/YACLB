(in-package :yaclb)

(defcmd :args (reply (format nil "~D args = ~A" num-args args)))
(defcmd :sender (reply (format nil "~A" (irc:source message))))
(defcmd :uname (reply (inferior-shell:run/ss "uname -a")))
(defcmd :uptime (reply (inferior-shell:run/ss "uptime")))
(defcmd :dbver (reply (format nil "CouchDB v~A" (clouchdb:document-property :|version| (clouchdb:get-couchdb-info)))))
(defcmd "dbinfo"
    (let ((info (clouchdb:get-db-info)))
      (reply (join-with "; " (map 'list
				  #'(lambda (prop) 
				      (if (clouchdb:document-property prop info)
					  (format nil "~A=~A" prop (clouchdb:document-property prop info))
					  prop))
				  (map 'list 'car info))))))


