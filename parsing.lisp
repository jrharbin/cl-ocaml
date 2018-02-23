(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun i2p (a b c)
    "Infix to prefix"
    (list b a c))
  
  (defun k-2-3 (a b c)
    "Second out of three"
    (declare (ignore a c))
    b))

(yacc:define-parser *ocaml-parser*
  (:start-symbol seq_expr)
  (:terminals (Identifier Int
			  Plus
			  BinOp
			  Equals MinusGreater Underscore Tilde Semi
			  Let Fun IN
			  LParen RParen))
  (:precedence ((:nonassoc IN SEMI LET FUN)
		(:right Equals MinusGreater BinOp)
		(:left BinOp Equals)))

  (seq_expr
   (expr)
   (expr SEMI)
   (expr SEMI seq_expr))

  (simple_expr
   (Int)
   (Identifier)
   (LParen seq_expr RParen))
  
  (expr
   (simple_expr)
   (LET Identifier Equals expr IN expr)
   (LET Identifier Equals expr)
   (FUN Identifier MinusGreater expr)
   (expr BinOp expr)))

(defun test-parse (str)
  "Tests parsing the given string"
  (debug-print-lexing str)
  (yacc:parse-with-lexer (ocaml-lexer str)
			 *ocaml-parser*))
