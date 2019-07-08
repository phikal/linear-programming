(uiop:define-package :linear-programming/conditions
  (:use :cl)
  (:export #:parsing-error
           #:solver-error
           #:infeasible-problem-error
           #:infeasible-integer-constraints-error
           #:unbounded-problem-error
           #:nonlinear-error)
  (:documentation "Contains the various conditions used by this library."))
(in-package :linear-programming/conditions)


(define-condition parsing-error (error)
  ((description :reader description
                :initarg :description))
  (:report (lambda (err stream) (format stream (description err))))
  (:documentation "Indicates an error occured while parsing a linear problem.
                   Includes a textual description of the issue."))

(define-condition nonlinear-error (parsing-error)
  ((expression :reader nonlinear-expression
               :initarg :expression
               :documentation "Contains the problematic expression"))
  (:report (lambda (err stream) (format stream "~S is not a linear expression" (nonlinear-expression err))))
  (:documentation "Indicates a form was not a linear expression.  This includes
                   the use of nonlinear functions and taking the product of
                   multiple variables"))

(define-condition solver-error (error)
  ()
  (:documentation "The base class for errors that occur with the solving algorithm."))

(define-condition unbounded-problem-error (solver-error)
  ()
  (:report (lambda (err stream)
             (declare (ignore err))
             (format stream "Problem is unbounded")))
  (:documentation "Indicates the feasible region is unbounded such that the
                   optimal objective value is infinite."))

(define-condition infeasible-problem-error (solver-error)
  ()
  (:report (lambda (err stream)
             (declare (ignore err))
             (format stream "Problem has no feasible region")))
  (:documentation "Indicates the there is no feasible region."))

(define-condition infeasible-integer-constraints-error (infeasible-problem-error)
  ()
  (:report (lambda (err stream)
             (declare (ignore err))
             (format stream "Integer constrains could not be satisfied")))
  (:documentation "Indicates that there is no feasible region due to the integer
                   constraints."))