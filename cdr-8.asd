;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cl-user; -*-

(in-package #:cl-user)

(asdf:defsystem #:cdr-8
  :in-order-to ((asdf:test-op (asdf:load-op #:cdr-8-tests)))
  :perform (asdf:test-op :after (op c)
             (funcall (find-symbol (symbol-name '#:run!) '#:fiveam)
                      (find-symbol (symbol-name '#:cdr-8) '#:cdr-8-tests)))
  :serial T
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "equals")))))
