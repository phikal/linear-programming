
(uiop:define-package :linear-programming-test/problem
  (:use :cl
        :fiveam
        :linear-programming-test/base
        :linear-programming-test/test-utils
        :linear-programming/problem)
  (:export #:problem))

(in-package :linear-programming-test/problem)

(def-suite problem
  :in linear-programming
  :description "The suite to test linear-programming/problem")
(in-suite problem)

(test make-linear-problem
  (signals parsing-error
           (make-linear-problem (avg (+ x (* 4 y) (* 8 z)))
                                (<= (+ x y) 8)
                                (<= (+ y z) 7)))

  (signals parsing-error
           (make-linear-problem (min (+ x (* 4 y) (* 8 z)))
                                (& (+ x y) 8)
                                (<= (+ y z) 7)))

  (signals parsing-error
           (make-linear-problem (min (+ x (* 4 y) (* 8 z)))
                                (<= (+ x y) 8)
                                (<= (+ y z) 7)
                                (foobar x)))

  (let ((problem (make-linear-problem (max (+ x (* 4 y) (* 8 z)))
                                      (<= (+ x y) 8)
                                      (<= (+ y z) 7))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . 4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-signed-vars problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                   (problem-constraints problem))))

  (let ((problem (make-linear-problem (max (+ x (* 4 y) (* 8 z)))
                                      (<= (+ (* 2 x) y) 8)
                                      (<= (+ y z) 7)
                                      (>= (+ x z) 1))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . 4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-signed-vars problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 2) (y . 1)) 8)
                     (<= ((y . 1) (z . 1)) 7)
                     (>= ((x . 1) (z . 1)) 1))
                   (problem-constraints problem))))

  (let ((problem (make-linear-problem (max (+ x (* 4 y) (* 8 z)))
                                      (<= (+ (* 2 x) y) 8)
                                      (<= (+ y z) 7)
                                      (= (+ (* 2 x) y z) 8))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . 4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-signed-vars problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 2) (y . 1)) 8)
                     (<= ((y . 1) (z . 1)) 7)
                     (= ((x . 2) (y . 1) (z . 1)) 8))
                   (problem-constraints problem))))

  ; signed constraint
  (let ((problem (make-linear-problem (= total (max (+ x (* -4 y) (* 8 z))))
                                      (<= (+ x y) 8)
                                      (<= (+ (* -1 y) z) 7)
                                      (signed y))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is (eq 'total (problem-objective-var problem)))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . -4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '(y)
                   (problem-signed-vars problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . -1) (z . 1)) 7))
                   (problem-constraints problem))))

  ; integer constraint
  (let ((problem (make-linear-problem (max (= total (+ x (* -4 y) (* 8 z))))
                                      (<= (+ x y) 8)
                                      (<= (+ (* -1 y) z) 7)
                                      (integer y))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is (eq 'total (problem-objective-var problem)))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . -4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-signed-vars problem)))
    (is (set-equal '(y)
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . -1) (z . 1)) 7))
                   (problem-constraints problem))))

  ;binary variable
  (let ((problem (make-linear-problem (max (= total (+ x (* -4 y) (* 8 z))))
                                      (<= (+ x y) 8)
                                      (<= (+ (* -1 y) z) 7)
                                      (binary y))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is (eq 'total (problem-objective-var problem)))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . -4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-signed-vars problem)))
    (is (set-equal '(y)
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8)
                     (<= ((y . -1) (z . 1)) 7)
                     (<= ((y . 1)) 1))
                   (problem-constraints problem))))

  ; objective func name within the max
  (let ((problem (make-linear-problem (max (= total (+ x (* -4 y) (* 8 z))))
                                      (<= (+ x y) 8)
                                      (<= (+ (* -1 y) z) 7)
                                      (signed y))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is (eq 'total (problem-objective-var problem)))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . -4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '(y)
                   (problem-signed-vars problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . -1) (z . 1)) 7))
                   (problem-constraints problem)))))

(test parse-linear-problem
  (let ((problem (parse-linear-problem '(max (+ x (* 4 y) (* 8 z)))
                                       '((<= (+ x y) 8)
                                         (<= (+ y z) 7)))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . 4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-signed-vars problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                   (problem-constraints problem)))))
