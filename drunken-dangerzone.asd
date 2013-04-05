;;;; drunken-dangerzone.asd

(asdf:defsystem #:drunken-dangerzone
  :serial t
  :description "Simple in-memory key-value store with a REST API."
  :author "Kyle Isom <coder@kyleisom.net>"
  :license "ISC license"
  :depends-on (#:restas
               #:cl-json
               #:kvstore)
  :components ((:file "package")
               (:file "drunken-dangerzone")))
