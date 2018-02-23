(defun test-parse (str)
  (debug-print-lexing str)
  (yacc:parse-with-lexer (ocaml-lexer str)
			 *ocaml-parser*))
		  
(defun test ()
  (test-parse "x"))

(defun repl ()
  )
