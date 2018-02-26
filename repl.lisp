;; Needed processing sequence from string input:

;; Lexing/parsing of input into parse tree representation
;; Conversion to a typed tree representation
;; Unification of expression with known types
;; Handle conditions for errors in any of these

;; Backend(s): for now, 1) compile to CL code
;;                      2) something more exciting

(defun repl-on-streams (stdin stdout)
  (let ((continue t)
	(show-parse-tree t)
	(prompt "cl-ocaml REPL"))
	(loop while continue do
	     (format stdout "~A>" prompt)
	     (let1 str (read-line stdin)
	       (cond ((equalp str "#exit") (setf continue nil))
		     (t (if show-parse-tree
			    (print (test-parse str))))))
	     (terpri))))

(defun repl ()
  (repl-on-streams *standard-input* *standard-output*))
