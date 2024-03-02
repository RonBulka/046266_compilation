#!/bin/bash
make clean
make
./part1 < run_examples/comment.cmm > ourout0.out
./part1 < run_examples/example.cmm > ourout1.out
./part1 < run_examples/example2.cmm > ourout2.out
./part1 < run_examples/example-err.cmm > ourout3.out
./part1 < run_examples/example-err2.cmm > ourout4.out
./part1 < run_examples/example-err3.cmm > ourout5.out
diff ourout0.out run_examples/comment.tokens
diff ourout1.out run_examples/example.tokens
diff ourout2.out run_examples/example2.tokens
diff ourout3.out run_examples/example-err.tokens
diff ourout4.out run_examples/example-err2.tokens
diff ourout5.out run_examples/example-err3.tokens
#rm -rf ourout*