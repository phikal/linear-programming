
(uiop:define-package :linear-programming/expressions
  (:use :cl
         :alexandria
         :iterate)
  (:export #:scale-linear-expression
           #:combine-linear-expressions
           #:parse-linear-expression
           #:+constant+))

(in-package :linear-programming/expressions)

(defun combine-linear-expressions (exprs)
  "Takes a list of linear expressions and reduces it into a single expression"
  (reduce #'(lambda (collected next)
              (if-let (pair (assoc (car next) collected))
                (progn
                  (incf (cdr pair) (cdr next))
                  collected)
                (cons (copy-list next) collected)))
          (apply 'append exprs)
          :initial-value nil))


(defun scale-linear-expression (expr scalar)
  "Multiplies the linear expression by the given scalar"
  (mapcar #'(lambda (x) (cons (car x) (* scalar (cdr x))))
          expr))


(defun parse-linear-expression (expr)
  "Parses the expression into a alist mapping variables to coefficients.
   Any constant values are mapped to +constant+"
  (cond
    ; atoms
    ((symbolp expr)
     (list (cons expr 1)))
    ((numberp expr)
     (list (cons '+constant+ expr)))

    ; error case
    ((not (listp expr))
     (error "~S is not a symbol, number, or an expression" expr))

    ; arithmetic
    ((eq (first expr) '+)
     (combine-linear-expressions (mapcar 'parse-linear-expression (rest expr))))
    ((eq (first expr) '*)
     (unless (= 3 (length expr))
       (error "Multiplication in linear expressions only supports two products"))
     (let ((prod1 (second expr))
           (prod2 (third expr)))
       (cond
         ((and (numberp prod1) (numberp prod2))
          (list (cons '+constant+ (* prod1 prod2))))
         ((and (numberp prod1) (symbolp prod2))
          (list (cons prod2 prod1)))
         ((and (symbolp prod1) (numberp prod2))
          (list (cons prod1 prod2)))
         (t (error "Cannot multiple ~A and ~A in a linear expression" prod1 prod2)))))))
    ;TODO implement subtraction
    ;TODO implememnt dividing coefficient