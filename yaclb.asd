(in-package :asdf)

(defsystem "yaclb"
  :description "yet another common lisp (irc) bot"
  :version "0.1.0"
  :author "William Meister <wmeister86@gmail.com>"
  :licence "Public Domain"
  :depends-on (:cl-irc :inferior-shell)
  :components ((:file "package")
	       (:file "string"
		      :depends-on ("package"))
	       (:file "var"
		      :depends-on ("package"))
	       (:file "macro"
		      :depends-on ("string"))
	       (:file "command"
		      :depends-on ("var" "macro"))
	       (:file "irc"
		      :depends-on ("var"))
	       (:file "main"
		      :depends-on ("command" "irc"))))
