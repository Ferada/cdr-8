;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cl-user; -*-

(in-package #:cl-user)

(defpackage #:cdr-8
  (:use #:cl)
  (:export #:equals
           #:compare
           #:lt #:lte #:gt #:gte
           #:lessp #:not-greaterp #:greaterp #:not-lessp
           #:hash-code))
