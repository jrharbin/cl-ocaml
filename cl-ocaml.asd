;;;; cl-ocaml.asd

(asdf:defsystem #:cl-ocaml
  :description "Toy implementation of OCaml in Common Lisp"
  :author "James Harbin <james.harbin@gmail.com>"
  :license "GPL2"
  :depends-on (#:yacc
               #:lexer)
  :serial t
  :components ((:file "customtypespec")
	       (:file "package")
	       (:file "macros")
	       (:file "lexing")
	       (:file "parse-helpers" :depends-on ("customtypespec"))
	       (:file "parsing" :depends-on ("lexing" "parse-helpers"))
	       (:file "repl" :depends-on ("parsing"))
	       (:file "test-parsing" :depends-on ("parsing"))
               (:file "main")))

