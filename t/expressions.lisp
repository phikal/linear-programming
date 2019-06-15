
(uiop:define-package :linear-programming-test/expressions
  (:use :cl
        :fiveam
        :linear-programming-test/base
        :linear-programming-test/test-utils
        :linear-programming/expressions)
  (:export #:expressions))

(in-package :linear-programming-test/expressions)

(def-suite expressions
  :in linear-programming
  :description "The suite to test linear-programming/expressions")
(in-suite expressions)

(test scale-linear-expression
  (is (equal '((a . 24) (b . 7/2) (c . 4.5))
             (scale-linear-expression '((a . 8) (b . 7/6) (c . 1.5))
                                      3)))
  (is (equal nil
             (scale-linear-expression nil 3)))
  (is (equal '((a . 4) (b . 7/12) (c . .75))
             (scale-linear-expression '((a . 8) (b . 7/6) (c . 1.5))
                                      1/2))))

(test combine-linear-expressions
  (is (eq nil (combine-linear-expressions nil)))
  (is (eq nil (combine-linear-expressions (list nil))))
  (is (eq nil (combine-linear-expressions (list nil nil))))
  (is (eq nil (combine-linear-expressions (list nil nil nil))))

  (is (set-equal '((a . 8) (b . 7/6) (c . 1.5))
                 (combine-linear-expressions '(((a . 8) (b . 7/6) (c . 1.5))))))
  (is (set-equal '((a . 12) (b . 19/6) (c . 2.0) (d . 6) (e . 7/4))
                 (combine-linear-expressions '(((a . 8) (b . 7/6) (c . 1.5) (d . 6))
                                               ((a . 4) (b . 2) (c . 1/2) (e . 7/4)))))))

(test parse-linear-expression
  (is (set-equal '((a . 1) (+constant+ . 5) (b . 8))
                 (parse-linear-expression '(+ a 5 (* 8 b)))))
  (signals error (parse-linear-expression '(* x y))))
