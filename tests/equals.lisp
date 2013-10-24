;;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8-tests; -*-

(in-package #:cdr-8-tests)

(in-suite equals)

(def-test numbers.1 ()
  (is-true (equals 1 1)))

(def-test symbols ()
  (is-true (equals 'a 'a)))

(def-test characters ()
  (is-true (equals #\a #\a :case-sensitive T))
  (is-true (equals #\ö #\ö :case-sensitive T))
  (is-false (equals #\a #\A :case-sensitive T))
  (is-false (equals #\ö #\Ö :case-sensitive T))
  (is-true (equals #\a #\A :case-sensitive NIL))
  (is-true (equals #\ö #\Ö :case-sensitive NIL)))

(def-test strings ()
  (is-true (equals "foo" "foo" :case-sensitive T))
  (is-true (equals "öäü" "öäü" :case-sensitive T))
  (is-false (equals "foo" "FOO" :case-sensitive T))
  (is-false (equals "öäü" "ÖÄÜ" :case-sensitive T))
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

(def-test aliases ()
  (is-true (eq #'lessp #'lt))
  (is-true (eq #'not-greaterp #'lte))
  (is-true (eq #'greaterp #'gt))
  (is-true (eq #'not-lessp #'gte)))
