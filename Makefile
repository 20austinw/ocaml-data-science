MODULES=matrix statistics 
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=$(MODULES:=.mli)
TEST=test.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	OCAMLRUNPARAM=b utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

zip: 
	zip data-science.zip *.ml* *.md _tags .merlin .ocamlformat Makefile 

clean:
	ocamlbuild -clean
	rm -rf _doc.public _doc.private 