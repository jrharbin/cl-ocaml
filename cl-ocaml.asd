;;;; cl-ocaml.asd

(asdf:defsystem #:mllisp
  :description "Toy implementation of OCaml in Common Lisp"
  :author "James Harbin <james.harbin@gmail.com>"
  :license "GPL2"
  :depends-on (#:yacc
               #:lexer)
  :serial t
  :components ((:file "package")
	       (:file "macros")
	       (:file "lexing")
	       (:file "parsing" :depends-on ("lexing"))
               (:file "main")))

