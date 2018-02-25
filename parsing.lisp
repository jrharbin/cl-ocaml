(eval-when (:compile-toplevel :load-toplevel :execute)
  ;; Expression term builders - expressions are a tuple of
  ;; expression_tag, value, type_placeholder, sub structure

  ;; Fix: use a structure for these
  (defun mk-int (i) (list 'E_Int i nil))
  (defun mk-float (f) (list 'E_Float f nil))
  (defun mk-ident (id) (list 'E_Ident id nil))
  
  (defun mk-binop (e1 binop e2) (list 'E_Binop binop nil e1 e2))
  (defun mk-exprlist (e1 s e2) (list 'E_Seq s nil (cons e1 e2)))

  (defun mk-letbind (l id eq_ expr)
    (declare (ignore l eq_))
    (list 'E_LetBind id nil expr))

  (defun mk-letbind-in (l id eq_ e1 in_ e2)
    (declare (ignore l eq_ in_))
    (list 'E_LetBind id nil e1 e2))
  
  (defun mk-apply (e1 e2)
    (list 'E_Apply nil nil (cons e1 e2)))
  
  (defun mk-fun (fun id arrow_ e)
    (declare (ignore fun arrow_))
    (list 'E_Fun id nil e)))

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
      (expr Semi expr #'mk-exprlist)  ;; Fix the functions to generate here
      (expr Semi #'car))
     
     (simple_expr
      (Int #'mk-int)
      (Float #'mk-float)
      (Identifier #'mk-ident)
      (LParen expr RParen) #'second)
     
     (simple_expr_list
      (simple_expr simple_expr_list #'cons)
      (simple_expr #'list))))

(define-parser-start-symbol *ocaml-parser* expr)
(define-parser-start-symbol *impl-parser* implementation)

(defun test-parse (str)
  "Tests parsing the given string"
  (debug-print-lexing str)
  (yacc:parse-with-lexer (ocaml-lexer str)
			 *ocaml-parser*))
