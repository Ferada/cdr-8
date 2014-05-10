;;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8-tests; -*-

(in-package #:cdr-8-tests)

(in-suite equals)

(def-test numbers.1 ()
  (is (equals 1 1)))

(def-test symbols ()
  (is (equals 'a 'a)))

(def-test characters ()
  (is (equals #\a #\a :case-sensitive T))
  (is (equals #\ö #\ö :case-sensitive T))
  (is (not (equals #\a #\A :case-sensitive T)))
  (is (not (equals #\ö #\Ö :case-sensitive T)))
  (is (equals #\a #\A :case-sensitive NIL))
  (is (equals #\ö #\Ö :case-sensitive NIL)))

(def-test strings ()
  (is (equals "foo" "foo" :case-sensitive T))
  (is (equals "öäü" "öäü" :case-sensitive T))
  (is (not (equals "foo" "FOO" :case-sensitive T)))
  (is (not (equals "öäü" "ÖÄÜ" :case-sensitive T)))
  (is (equals "foo" "FOO" :case-sensitive NIL))
  (is (equals "öäü" "ÖÄÜ" :case-sensitive NIL)))

(def-test arrays ()
  (is (equals #(1 2 3) #(1 2 3)))
  (is (not (equals #(1 2 3) #(4 5 6))))
  (is (equals (make-array '(2 3)) (make-array '(2 3))))
  (is (not (equals (make-array '(3 3)) (make-array '(2 3))))))

(def-test fill-pointer ()
  (let ((a (make-array 8 :fill-pointer 4))
        (b (make-array 4)))
    (is (equals a b))))

(def-test cons ()
  (is (equals (list 1 'a #\a "asdf") (list 1 'A #\A "AsDf") :case-sensitive NIL)))

(defstruct foo ())

(def-test structure-object ()
  (let ((a (make-foo))
        (b (make-foo)))
    (is (equals a a))
    (is (equals a b))))

(defclass bar () ())

(def-test standard-object ()
  (let ((a (make-instance 'bar))
        (b (make-instance 'bar)))
    (is (equals a a))
    (is (not (equals a b)))))

(def-test aliases ()
  (is (eq #'lessp #'lt))
  (is (eq #'not-greaterp #'lte))
  (is (eq #'greaterp #'gt))
  (is (eq #'not-lessp #'gte)))

(def-test hash-tables ()
  (is (equals (make-hash-table) (make-hash-table)))
  (let ((a (make-hash-table :test #'equal))
        (b (make-hash-table :test #'equal)))
    (loop
      for x in '("FOO" "bar" "BAZ")
      for y in '(1 2.0 3)
      do (setf (gethash x a) y))
    (loop
      for x in '("foo" "BAR" "baz")
      for y in '(1.0 2 3.0)
      do (setf (gethash x b) y))
    (is (equals a b))
    (is (equals a b :case-sensitive NIL))))
