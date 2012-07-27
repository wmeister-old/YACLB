(in-package :asdf)

(defsystem "yaclb"
  :description "yet another common lisp (irc) bot"
  :version "0.1.0"
  :author "William Meister <wmeister86@gmail.com>"
  :licence "Public Domain"
  :depends-on (:cl-irc)
  :components ((:file "package")
	       (:file "irc"
		      :depends-on ("package"))
	       (:file "list"
		      :depends-on ("package"))
	       (:file "string"
		      :depends-on ("package"))
	       (:file "var"
		      :depends-on ("package"))
	       (:file "macro"
		      :depends-on ("package"))
	       (:file "command"
		      :depends-on ("var" "macro"))
	       (:file "main"
		      :depends-on ("command" "irc" "list" "string"))))
