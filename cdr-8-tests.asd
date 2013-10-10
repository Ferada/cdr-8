;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cl-user; -*-

(in-package #:cl-user)

(asdf:defsystem #:cdr-8-tests
  :depends-on (#:fiveam)
  :serial T
  :components ((:module "tests"
                :components
                ((:file "package")
                 (:file "suite")
                 (:file "equals")))))
