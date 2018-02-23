(defmacro let1 (name val &body body)
  "Let bind a single value"
  `(let ((,name ,val))
     ,@body))
