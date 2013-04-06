;;;; drunken-dangerzone.lisp
;;; simple in-memory key-value server with a REST API.
;;; written by Kyle Isom <coder@kyleisom.net>
(ql:quickload :restas)
(ql:quickload :st-json)
(ql:quickload :cl-who)

(defvar *port* 8080)

(defun run ()
  (restas:start '#:drunken-dangerzone :port *port*))

(defun stop ()
  (restas:stop-all))

;;; "drunken-dangerzone" goes here. Hacks and glory await!
(restas:define-module #:drunken-dangerzone
    (:use #:cl #:restas))

(in-package #:drunken-dangerzone)

(defparameter *opts* '(("p" :required)))
(defvar *keystore* (make-hash-table :test #'equal))

(defmacro write-json-fields (&body body)
  `(st-json:write-json-to-string
    (st-json:jso ,@body)))

(defun error-response (err-msg)
  (write-json-fields "error" err-msg
                     "success" :false))

(defun success-response (msg)
  (write-json-fields "message" msg
                     "success" :true))

(restas:define-route keylist ("/key" :method :get)
  (st-json:write-json-to-string
   (let ((keylst '()))
     (maphash (lambda (k v)
                (declare (ignore v))
                (push k keylst))
              *keystore*)
     keylst)))

(restas:define-route getkey ("/key/:key" :method :get)
  (st-json:write-json-to-string (st-json:jso key
                                             (gethash key *keystore*))))

(defun key-in-store (key)
  (multiple-value-bind (v ok) (gethash key *keystore*)
    (declare (ignore v))
    ok))

(restas:define-route putkey ("/key" :method :put)
  (let ((keyvalues (st-json:read-json-from-string
                    (hunchentoot:raw-post-data :force-text t)))
        (keys-set '())
        (not-updated '()))
    (st-json:mapjso (lambda (k v)
                      (if (key-in-store k)
                          (push k not-updated)
                          (progn
                            (setf (gethash k *keystore*) v)
                            (push k keys-set))))
                    keyvalues)
    (write-json-fields
            "set" keys-set
            "not-updated" not-updated
            "success" :true)))

(restas:define-route postkey ("/key" :method :post)
  (let ((keyvalues (st-json:read-json-from-string
                    (hunchentoot:raw-post-data :force-text t)))
        (keys-set '()))
    (st-json:mapjso (lambda (k v)
                      (setf (gethash k *keystore*) v)
                      (push k keys-set))
                    keyvalues)
    (write-json-fields "success" :true
                       "set" keys-set)))

(restas:define-route dump ("/keystore.json" :method :get)
  (let ((store '()))
    (maphash (lambda (k v) (progn (push v store)
                                  (push k store)))
             *keystore*)
    (st-json:write-json-to-string (apply #'st-json:jso store))))

(restas:define-route index ("/" :method :get)
  (who:with-html-output-to-string (out)
      (:html
       (:head
        (:title "drunken-dangerzone")
        (:meta :http-equiv "Content-Type"
               :content    "text/html;charset=utf-8"))
       (:body
        (:h1 "drunken-dangerzone!")
        (:p "This is a simple in-memory key-value store powered by Common Lisp.")
        (:p "Supported endpoints:"
            (:ul
             (:li "GET /key     - retrieve a list of all keys stored in the server")
             (:li "PUT /key     - json-encode a list of keys and their values, "
                  "and they will be stored as long as they aren't already "
                  "present")
             (:li "POST /key    - similar to PUT, but will overwrite any"
                  "existing values.")
             (:li "GET /key/:id - retrieve the value associated with the id.")
             (:li "GET /keystore.json - retrieve the full keystore as json.")))))))
