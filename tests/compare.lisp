;;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8-tests; -*-

(in-package #:cdr-8-tests)

(in-suite compare)

(def-test numbers.1 ()
  (is (eq '= (compare 1 1)))
  (is (eq '< (compare 1 2)))
  (is (eq '> (compare 2 1))))

(def-test numbers.2 ()
  (is (eq '/= (compare #C(1 2) #C(2 1)))))
