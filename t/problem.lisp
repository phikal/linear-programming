
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
                   (problem-integer-vars problem)))
    (is (set-equal '()
                   (problem-var-bounds problem)))
    (is (simple-linear-constraint-set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                                        (problem-constraints problem))))

  (let ((problem (make-linear-problem (max (+ x (* 4 y) (* 8 z)))
                                      (<= (+ (* 2 x) y) 8)
                                      (<= (+ y z) 7)
                                      (>= (+ x z) 1)
                                      (<= x y))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . 4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                  (problem-integer-vars problem)))
   (is (set-equal '()
                  (problem-var-bounds problem)))
   (is (simple-linear-constraint-set-equal '((<= ((x . 2) (y . 1)) 8)
                                             (<= ((y . 1) (z . 1)) 7)
                                             (>= ((x . 1) (z . 1)) 1)
                                             (<= ((x . 1) (y . -1)) 0))
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
                   (problem-integer-vars problem)))
    (is (set-equal '()
                   (problem-var-bounds problem)))
    (is (simple-linear-constraint-set-equal '((<= ((x . 2) (y . 1)) 8)
                                              (<= ((y . 1) (z . 1)) 7)
                                              (= ((x . 2) (y . 1) (z . 1)) 8))
                                        (problem-constraints problem))))

  (let ((problem (make-linear-problem (min x)
                                      (<= x 8))))
    (is (typep problem 'problem))
    (is (eq 'min (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(x)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((x . (0 . 8)))
                   (problem-var-bounds problem)))
    (is (simple-linear-constraint-set-equal '()
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
    (is (set-equal '(y)
                   (problem-integer-vars problem)))
    (is (set-equal '()
                   (problem-var-bounds problem)))
    (is (simple-linear-constraint-set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . -1) (z . 1)) 7))
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
    (is (set-equal '(y)
                   (problem-integer-vars problem)))
    (is (set-equal '((y . (0 . 1)))
                   (problem-var-bounds problem)))
    (is (simple-linear-constraint-set-equal '((<= ((x . 1) (y . 1)) 8)
                                              (<= ((y . -1) (z . 1)) 7))
                                        (problem-constraints problem))))

  ; free variable
  (signals parsing-error
           (make-linear-problem (min (+ x (* 4 y) (* 8 z)))
                                (<= (+ x y) 8)
                                (<= (+ y z) 7)
                                (bounds (x y))))
  (signals parsing-error
           (make-linear-problem (min (+ x (* 4 y) (* 8 z)))
                                (<= (+ x y) 8)
                                (<= (+ y z) 7)
                                (bounds (1 x y))))
  (let ((problem (make-linear-problem (max (= total (+ x (* -4 y) (* 8 z))))
                                      (<= (+ x y) 8)
                                      (<= (+ (* -1 y) z) 7)
                                      (bounds (x) (1 y) (-10 z 5)))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is (eq 'total (problem-objective-var problem)))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . -4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((x . (nil . nil)) (y . (1 . nil)) (z . (-10 . 5)))
                   (problem-var-bounds problem)))
    (is (simple-linear-constraint-set-equal '((<= ((x . 1) (y . 1)) 8)
                                              (<= ((y . -1) (z . 1)) 7))
                                        (problem-constraints problem))))
  (let ((problem (make-linear-problem (max (= total (+ x (* -4 y) (* 8 z))))
                                      (<= (+ x y) 8)
                                      (<= (+ (* -1 y) z) 7)
                                      (bounds (1 y) (z -5))
                                      (bounds (y 8)))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is (eq 'total (problem-objective-var problem)))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((x . 1) (y . -4) (z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((y . (1 . 8)) (z . (nil . -5)))
                   (problem-var-bounds problem)))
    (is (simple-linear-constraint-set-equal '((<= ((x . 1) (y . 1)) 8)
                                              (<= ((y . -1) (z . 1)) 7))
                                        (problem-constraints problem))))

 ; objective func name within the max
 (let ((problem (make-linear-problem (max (= total (+ x (* -4 y) (* 8 z))))
                                     (<= (+ x y) 8)
                                     (<= (+ (* -1 y) z) 7))))
   (is (typep problem 'problem))
   (is (eq 'max (problem-type problem)))
   (is (typep (problem-vars problem) 'vector))
   (is (eq 'total (problem-objective-var problem)))
   (is (set-equal '(x y z)
                  (map 'list #'identity (problem-vars problem))))
   (is (set-equal '((x . 1) (y . -4) (z . 8))
                  (problem-objective-func problem)))
   (is (set-equal '()
                  (problem-integer-vars problem)))
   (is (set-equal '()
                  (problem-var-bounds problem)))
   (is (simple-linear-constraint-set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . -1) (z . 1)) 7))
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
                   (problem-integer-vars problem)))
    (is (simple-linear-constraint-set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                                        (problem-constraints problem)))))
