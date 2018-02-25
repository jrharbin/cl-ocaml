(defun elements-are-of-type (seq type)
  (every #'(lambda (x) (typep x type)) seq))

(deftype list-of-type (type)
  (let ((predicate (gensym)))
    (format t "Defining predicate as gensym: ~A~%" predicate)
    (setf (symbol-function predicate)
      #'(lambda (seq) (elements-are-of-type seq type)))
    `(and list (satisfies ,predicate))))
