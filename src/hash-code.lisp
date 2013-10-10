;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8; -*-

(in-package #:cdr-8)

(defgeneric hash-code (a))

(defmethod hash-code ((a T))
  (sxhash a))
