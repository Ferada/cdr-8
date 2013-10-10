(in-package #:cdr-8)

(defgeneric equals (a b &rest keys &key recursive &allow-other-keys))

(defmethod equals ((a T) (b T) &rest keys)
  (declare (ignore keys))
  (equalp a b))

(defmethod equals ((a number) (b number) &rest keys)
  (declare (ignore keys))
  (= a b))

(defmethod equals ((a cons) (b cons) &rest keys)
  (tree-equal a b :test (lambda (x y) (apply #'equals x y keys))))

(defmethod equals ((a character) (b character) &rest keys &key (case-sensitive T))
  (declare (ignore keys))
  (if case-sensitive
      (char= a b)
      (char-equal a b)))

(defmethod equals ((a string) (b string) &rest keys &key (case-sensitive T))
  (declare (ignore keys))
  (if case-sensitive
      (string= a b)
      (string-equal a b)))

;; TODO: ARRAY

(defmethod equals ((a structure-object) (b structure-object) &rest keys)
  (declare (ignore keys))
  (eq a b))

;; TODO: this would be implementation defined (wtf?)
(defmethod equals ((a standard-object) (b standard-object) &rest keys)
  (declare (ignore keys))
  (eq a b))

;; TODO: HASH-TABLE
