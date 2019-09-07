
(uiop:define-package :linear-programming-test/external-formats
  (:use :cl
        :fiveam
        :linear-programming-test/base
        :linear-programming-test/test-utils
        :linear-programming/external-formats
        :linear-programming/problem)
  (:export #:external-formats))

(in-package :linear-programming-test/external-formats)

(def-suite external-formats
  :in linear-programming
  :description "The suite to test linear-programming/external-formats")
(in-suite external-formats)

(def-suite sexp
  :in external-formats
  :description "The suite to test sexp representation of linear problems")
(in-suite sexp)

(test read-sexp
  (let ((problem (with-input-from-string (stream "((max (+ x (* 4 y) (* 8 z)))
                                                   (<= (+ x y) 8)
                                                   (<= (+ y z) 7))")
                   (read-sexp stream))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(cl-user::x cl-user::y cl-user::z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((cl-user::x . 1) (cl-user::y . 4) (cl-user::z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((cl-user::x . 1) (cl-user::y . 1)) 8) (<= ((cl-user::y . 1) (cl-user::z . 1)) 7))
                   (problem-constraints problem))))

  ;; read eval
  (signals error (with-input-from-string (stream "((max (+ x (* 4 y) (* 8 z)))
                                                   (<= (+ x y) #.(+ 4 4))
                                                   (<= (+ y z) 7))")
                   (read-sexp stream)))
  (let ((problem (with-input-from-string (stream "((max (+ x (* 4 y) (* 8 z)))
                                                   (<= (+ x y) #.(+ 4 4))
                                                   (<= (+ y z) 7))")
                   (read-sexp stream :allow-read-eval t))))
    (is (typep problem 'problem))
    (is (eq 'max (problem-type problem)))
    (is (typep (problem-vars problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var problem))))
    (is (set-equal '(cl-user::x cl-user::y cl-user::z)
                   (map 'list #'identity (problem-vars problem))))
    (is (set-equal '((cl-user::x . 1) (cl-user::y . 4) (cl-user::z . 8))
                   (problem-objective-func problem)))
    (is (set-equal '()
                   (problem-integer-vars problem)))
    (is (set-equal '((<= ((cl-user::x . 1) (cl-user::y . 1)) 8) (<= ((cl-user::y . 1) (cl-user::z . 1)) 7))
                   (problem-constraints problem))))

  ;;specify package
  (let ((problem (with-input-from-string (stream "((max (+ x (* 4 y) (* 8 z)))
                                                   (<= (+ x y) 8)
                                                   (<= (+ y z) 7))")
                   (read-sexp stream :package :linear-programming-test/external-formats))))
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
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                   (problem-constraints problem)))

   ;;Only read sexp
   (let ((problem (with-input-from-string (stream "((max (+ x (* 4 y) (* 8 z)))
                                                    (<= (+ x y) 8)
                                                    (<= (+ y z) 7))456")
                    (prog1
                     (read-sexp stream :package :linear-programming-test/external-formats)
                     (is (= (read stream) 456))))))
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
     (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                    (problem-constraints problem))))))


(test write-sexp
  (let* ((base-problem (parse-linear-problem '(max (+ x (* 4 y) (* 8 z)))
                                             '((<= (+ x y) 8)
                                               (<= (+ y z) 7))))
         (string (with-output-to-string (stream)
                   (write-sexp stream base-problem)))
         (parsed-problem (with-input-from-string (stream string)
                           (read-sexp stream))))
    (is (typep parsed-problem 'problem))
    (is (eq 'max (problem-type parsed-problem)))
    (is (typep (problem-vars parsed-problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var parsed-problem))))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars parsed-problem))))
    (is (set-equal '((x . 1) (y . 4) (z . 8))
                   (problem-objective-func parsed-problem)))
    (is (set-equal '()
                   (problem-integer-vars parsed-problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                   (problem-constraints parsed-problem))))

  ;;specify package
  (let* ((base-problem (parse-linear-problem '(max (+ x (* 4 y) (* 8 z)))
                                             '((<= (+ x y) 8)
                                               (<= (+ y z) 7))))
         (string (with-output-to-string (stream)
                   (write-sexp stream base-problem :package :linear-programming)))
         (parsed-problem (with-input-from-string (stream string)
                           (read-sexp stream :package (find-package :linear-programming)))))
    (is (typep parsed-problem 'problem))
    (is (eq 'max (problem-type parsed-problem)))
    (is (typep (problem-vars parsed-problem) 'vector))
    (is-true (null (symbol-package (problem-objective-var parsed-problem))))
    (is (set-equal '(x y z)
                   (map 'list #'identity (problem-vars parsed-problem))))
    (is (set-equal '((x . 1) (y . 4) (z . 8))
                   (problem-objective-func parsed-problem)))
    (is (set-equal '()
                   (problem-integer-vars parsed-problem)))
    (is (set-equal '((<= ((x . 1) (y . 1)) 8) (<= ((y . 1) (z . 1)) 7))
                   (problem-constraints parsed-problem)))))