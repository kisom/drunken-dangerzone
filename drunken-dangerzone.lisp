;;;; drunken-dangerzone.lisp
(in-package #:drunken-dangerzone)

;;; "drunken-dangerzone" goes here. Hacks and glory await!
(restas:define-module #:web.drunken-dangerzone)
(in-package #:web.drunken-dangerzone)


(defparameter web.drunken-dangerzone:*keystore* (kvstore:make-keystore :type :hashtable))
