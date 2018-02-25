(defun expr-list-p (l) (every #'(lambda (x) (typep x 'expr)) l))
(deftype expr-list () '(satisfies expr-list-p))

(defstruct expr
  (tag :E_Unit :type (member :E_Unit :E_Int
			     :E_Float :E_Ident
			     :E_Binop :E_Seq
			     :E_Letbind :E_Letbind_in
			     :E_Apply :E_Fun))
  val
  (sub-exprs () :type list))

(defun mk-expr (&key tag val sub-exprs)
  (check-type sub-exprs expr-list)
  (make-expr :tag tag :val val :sub-exprs sub-exprs))

(defun mk-int (i)
  (mk-expr :tag :E_Int :val i))

(defun mk-float (f)
  (mk-expr :tag :E_Float :val f))

(defun mk-ident (id)
  (mk-expr :tag :E_Ident :val id))

(defun mk-binop (e1 binop e2)
  (mk-expr :tag :E_Binop :val binop
	     :sub-exprs (list e1 e2)))

(defun mk-expr-seq (e1 s e2)
  (declare (ignore s))
  (mk-expr :tag :E_Seq :val nil
	     :sub-exprs (list e1 e2)))

(defun mk-letbind (l id eq_ expr)
  (declare (ignore l eq_))
  (mk-expr :tag :E_Letbind :val id
	     :sub-exprs (list expr)))

(defun mk-letbind-in (l id eq_ e1 in_ e2)
  (declare (ignore l eq_ in_))
  (mk-expr :tag :E_Letbind_in :val id
	     :sub-exprs (list e1 e2)))

(defun mk-apply (e1 e2)
  (mk-expr :tag :E_Apply :val nil
	     :sub-exprs (list e1 e2)))

(defun mk-fun (fun id arrow_ e)
  (declare (ignore fun arrow_))
  (mk-expr :tag :E_Fun :val id
	     :sub-exprs (list e)))
