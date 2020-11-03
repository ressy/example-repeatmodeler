SHELL = /bin/bash

all: db/example-families.fa

db/NC_036901.1.fasta: db/NC_036901.1.fasta.gz
	gunzip < $< > $@

db/example.nsq: db/NC_036901.1.fasta
	BuildDatabase -name $(basename $@) $<

db/example-families.fa: db/example.nsq
	RepeatModeler -database $(basename $<)

clean:
	rm -rf RM_*.*/
	rm -f db/example-families.{fa,stk}
	rm -f db/example.{nhr,nin,nnd,nni,nog,nsq,translation}
