;; -*- mode: lisp; syntax: common-lisp; coding: utf-8-unix; package: cdr-8; -*-

(in-package #:cdr-8)

(defgeneric equals (a b &key &allow-other-keys))

(defmethod equals ((a T) (b T) &key &allow-other-keys)
  (equalp a b))

(defmethod equals ((a number) (b number) &key &allow-other-keys)
  (= a b))

(defmethod equals ((a cons) (b cons) &rest keys &key &allow-other-keys)
  (tree-equal a b :test (lambda (x y) (apply #'equals x y keys))))

(defmethod equals ((a character) (b character) &key (case-sensitive T)
                                               &allow-other-keys)
  (if case-sensitive
      (char= a b)
      (char-equal a b)))

(defmethod equals ((a string) (b string) &key (case-sensitive T)
                                         &allow-other-keys)
  (if case-sensitive
      (string= a b)
      (string-equal a b)))

(defmethod equals ((a array) (b array) &rest keys &key &allow-other-keys)
  (or (eq a b)
      (when (equal (array-dimensions a) (array-dimensions b))
        (loop
          for i below (array-total-size a)
          always (apply #'equals (row-major-aref a i) (row-major-aref b i)
                        keys)))))

(defmethod equals ((a vector) (b vector) &rest keys &key &allow-other-keys)
  (or (eq a b)
      (let ((a-length (length a)))
        (when (eql a-length (length b))
          (loop
            for i below a-length
            always (apply #'equals (aref a i) (aref b i) keys))))))

(defmethod equals ((a simple-vector) (b simple-vector)
                   &rest keys &key &allow-other-keys)
  (or (eq a b)
      (let ((a-length (length a)))
        (when (eql a-length (length b))
          (loop
            for i below a-length
            always (apply #'equals (svref a i) (svref b i) keys))))))

(defmethod equals ((a structure-object) (b structure-object)
                   &key &allow-other-keys)
  (equalp a b))

(defmethod equals ((a standard-object) (b standard-object)
                   &key &allow-other-keys)
  (eq a b))

(defun hash-table-keys (hash-table)
  (let ((keys (make-sequence 'simple-vector (hash-table-count hash-table)))
        (i -1))
    (maphash (lambda (k v)
               (declare (ignore v))
               (setf (svref keys (incf i)) k))
             hash-table)
    keys))

(defun hash-table-values (hash-table)
  (let ((keys (make-sequence 'simple-vector (hash-table-count hash-table)))
        (i -1))
    (maphash (lambda (k v)
               (declare (ignore k))
               (setf (svref keys (incf i)) v))
             hash-table)
    keys))

;; IMO check-properties should default to NIL and a third option
;; by-key-and-value is needed so that we can check the hash-table actually
;; looks the same instead of just all keys the same and all values the same
;; also, this will cons like crazy
(defmethod equals ((a hash-table) (b hash-table)
                   &rest keys
                   &key (by-key T) (by-value T) (check-properties T)
                   &allow-other-keys)
  (or (eq a b)
      (when (eql (hash-table-count a) (hash-table-count b))
        (and (or (not check-properties)
                 (and (eq (hash-table-test a) (hash-table-test b))
                      (eql (hash-table-size a) (hash-table-size b))
                      (= (hash-table-rehash-size a) (hash-table-rehash-size b))
                      (= (hash-table-rehash-threshold a) (hash-table-rehash-threshold b))))
             (or (not by-key)
                 (let ((a-keys (sort (hash-table-keys a) #'lessp))
                       (b-keys (sort (hash-table-keys b) #'lessp)))
                   (loop
                     for a across a-keys
                     for b across b-keys
                     always (apply #'equals a b keys))))
             (or (not by-value)
                 (let ((a-values (sort (hash-table-values a) #'lessp))
                       (b-values (sort (hash-table-values b) #'lessp)))
                   (loop
                     for a across a-values
                     for b across b-values
                     always (apply #'equals a b keys))))))))
