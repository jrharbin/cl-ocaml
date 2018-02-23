(defun repl-on-streams (stdin stdout)
  (let ((continue t)
	(show-parse-tree t)
	(prompt "MLLisp REPL"))
	(loop while continue do
	     (format stdout "~A>" prompt)
	     (let1 str (read-line stdin)
	       (if show-parse-tree
		   (print (test-parse str)))
	       (terpri)))))

(defun repl ()
  (repl-on-streams *standard-input* *standard-output*))
