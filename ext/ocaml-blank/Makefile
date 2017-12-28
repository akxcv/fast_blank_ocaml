libblank-so:
	ocamlopt -output-obj -o blankcaml.o blank.ml
	ocamlc -c blank.c
	cc -o libblank.so blank.o blankcaml.o -L`ocamlc -where` -lunix -lasmrun
