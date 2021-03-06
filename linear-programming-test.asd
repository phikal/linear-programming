
(defsystem "linear-programming-test"
  :description "The tests for the linear-programming package"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :licence "MIT"
  :class :package-inferred-system
  :pathname "t"
  :depends-on ((:version "asdf" "3.1.6")
               "linear-programming-test/all")
  :perform (test-op (o c) (symbol-call '#:fiveam '#:run! (intern "LINEAR-PROGRAMMING" '#:linear-programming-test))))
