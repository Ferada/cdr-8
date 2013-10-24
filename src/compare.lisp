;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8; -*-

(in-package #:cdr-8)

(defgeneric compare (a b &key &allow-other-keys))

(defmethod compare ((a T) (b T) &key &allow-other-keys)
  '/=)

(defmethod compare ((a number) (b number) &key &allow-other-keys)
  (cond
   ((= a b) '=)
   ((and (realp a) (realp b))
    (if (< a b) '< '>))
   (T '/=)))

(defmethod compare ((a character) (b character) &key case-sensitive &allow-other-keys)
  (if case-sensitive
      (cond
       ((char= a b) '=)
       ((char< a b) '<)
       (T '>))
      (cond
       ((char-equal a b) '=)
       ((char-lessp a b) '<)
       (T '>))))

(defmethod compare ((a string) (b string) &key case-sensitive &allow-other-keys)
  (if case-sensitive
      (cond
       ((string= a b) '=)
       ((string< a b) '<)
       (T '>))
      (cond
       ((string-equal a b) '=)
       ((string-lessp a b) '<)
       (T '>))))

(defmethod compare ((a symbol) (b symbol) &key &allow-other-keys)
  (if (eq a b) '= '/=))

(define-condition uncomparable-objects-error ()
  ((objects :initarg :objects :reader uncomparable-objects-error-objects))
  (:report (lambda (condition stream)
             (format stream "Uncomparable objects~{~#[~; ~S~; ~S and ~S~:;~@{ ~S~#[~; and~:;,~]~}~]~}."
                            (uncomparable-objects-error-objects condition)))))

(defun uncomparable (a b)
  (error 'uncomparable-objects-error :objects (list a b)))

(defun lt (a b &rest keys &key &allow-other-keys)
  (case (apply #'compare a b keys)
   (< T)
   ((= >) NIL)
   (T (uncomparable a b))))

(defun lte (a b &rest keys &key &allow-other-keys)
  (case (apply #'compare a b keys)
   ((< =) T)
   (> NIL)
   (T (uncomparable a b))))

(defun gt (a b &rest keys &key &allow-other-keys)
  (case (apply #'compare a b keys)
   (> T)
   ((= <) NIL)
   (T (uncomparable a b))))

(defun gte (a b &rest keys &key &allow-other-keys)
  (case (apply #'compare a b keys)
   ((> =) T)
   (< NIL)
   (T (uncomparable a b))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (setf (fdefinition 'lessp) #'lt
        (fdefinition 'not-greaterp) #'lte
        (fdefinition 'greaterp) #'gt
        (fdefinition 'not-lessp) #'gte))
