;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8; -*-

(in-package #:cdr-8)

(defgeneric equals (a b &key &allow-other-keys))

(defmethod equals ((a T) (b T) &key &allow-other-keys)
  (equalp a b))

(defmethod equals ((a number) (b number) &key &allow-other-keys)
  (= a b))

(defmethod equals ((a cons) (b cons) &rest keys)
  (tree-equal a b :test (lambda (x y) (apply #'equals x y keys))))

(defmethod equals ((a character) (b character) &key case-sensitive &allow-other-keys)
  (if case-sensitive
      (char= a b)
      (char-equal a b)))

(defmethod equals ((a string) (b string) &key case-sensitive &allow-other-keys)
  (if case-sensitive
      (string= a b)
      (string-equal a b)))

;; TODO: ARRAY

(defmethod equals ((a structure-object) (b structure-object) &key &allow-other-keys)
  (eq a b))

;; TODO: this would be implementation defined (wtf?)
(defmethod equals ((a standard-object) (b standard-object) &key &allow-other-keys)
  (eq a b))

;; TODO: HASH-TABLE
