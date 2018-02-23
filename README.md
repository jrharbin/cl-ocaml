# cl-ocaml - Toy implementation of Ocaml in Common Lisp

This may do something interesting one day. For now there is only a
minimal toy lexer and parser that could eventually evolve towards a
functional language not totally dissimilar to Ocaml.

Start with (repl). For now it just spits out the raw parse tree
corresponding to the input strings:

CL-USER> (repl)
MLLisp REPL>let square = fun x -> x * x

((LET "square"
   EQUALS
   (FUN "x" MINUSGREATER ((("x")) INTMUL (("x")))))) 