(defmacro define-parser-start-symbol (parser-name start-sym)
  `(yacc:define-parser ,parser-name
     (:start-symbol ,start-sym)
     (:terminals (Identifier Int Float
			     Plus Minus 
			     Semi SemiSemi
			     BinOp
			     Equals MinusGreater Underscore Tilde
			     Let Fun IN
			     LParen RParen))
     (:precedence ((:nonassoc IN LET FUN SemiSemi)
		   (:right Equals MinusGreater Semi)
		   (:left BinOp Equals)
		   (:right simple_expr_list)))

     (implementation
      (expr SemiSemi #'car))
     
     (expr
      (simple_expr #'identity)
      (simple_expr simple_expr_list #'mk-apply)
      (LET Identifier Equals expr IN expr #'mk-letbind-in)
      (LET Identifier Equals expr #'mk-letbind)
      (FUN Identifier MinusGreater expr #'mk-fun)
      (expr BinOp expr #'mk-binop)
      (expr Semi expr #'mk-expr-seq)  ;; Fix the functions to generate here
      (expr Semi #'car))
     
     (simple_expr
      (Int #'mk-int)
      (Float #'mk-float)
      (Identifier #'mk-ident)
      (LParen expr RParen #'mk-parens))
     
     (simple_expr_list
      (simple_expr simple_expr_list #'list)
      (simple_expr #'identity))))

(define-parser-start-symbol *ocaml-parser* expr)
(define-parser-start-symbol *impl-parser* implementation)

(defun test-parse (str)
  "Tests parsing the given string"
  (debug-print-lexing str)
  (yacc:parse-with-lexer (ocaml-lexer str)
			 *ocaml-parser*))
