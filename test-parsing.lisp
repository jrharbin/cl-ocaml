(defparameter *parsing-test-expressions* 
  '("1"
    "1+2"
    "(1+2)"
    "1;2;3"
    "1/.5"
    "fun x -> 1 + x"
    "let y = 3"
    "let square = fun x -> x * x"))

(defun test-parsing-expressions ()
  (mapcar (lambda (str)
	    (format t "Expression = ~A: " str)
	    (print (test-parse str))
	    (terpri))
	  *parsing-test-expressions*))
  
