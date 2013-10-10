;;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8-tests; -*-

(in-package #:cdr-8-tests)

(in-suite equals)

(def-test numbers.1 ()
  (is-true (equals 1 1)))

(def-test symbols ()
  (is-true (equals 'a 'a)))

(def-test characters ()
  (is-true (equals #\a #\a))
  (is-true (equals #\ö #\ö))
  (is-false (equals #\a #\A))
  (is-false (equals #\ö #\Ö))
  (is-true (equals #\a #\A :case-sensitive NIL))
  (is-true (equals #\ö #\Ö :case-sensitive NIL)))

(def-test strings ()
  (is-true (equals "foo" "foo"))
  (is-true (equals "öäü" "öäü"))
  (is-false (equals "foo" "FOO"))
  (is-false (equals "öäü" "ÖÄÜ"))
  (is-true (equals "foo" "FOO" :case-sensitive NIL))
  (is-true (equals "öäü" "ÖÄÜ" :case-sensitive NIL)))

(def-test cons ()
  (is-true (equals (list 1 'a #\a "asdf") (list 1 'A #\A "AsDf") :case-sensitive NIL)))

(defstruct foo ())

(def-test structure-object ()
  (let ((a (make-foo))
        (b (make-foo)))
    (is-true (equals a a))
    (is-false (equals a b))))

(defclass bar () ())

(def-test standard-object ()
  (let ((a (make-instance 'bar))
        (b (make-instance 'bar)))
    (is-true (equals a a))
    (is-false (equals a b))))
