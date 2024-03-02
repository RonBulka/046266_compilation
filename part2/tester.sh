#!/bin/bash

make clean
make
./part2 < run_examples/example1.cmm > ourout1.out
./part2 < run_examples/example2.cmm > ourout2.out
./part2 < run_examples/example3.cmm > ourout3.out
./part2 < run_examples/example-err.cmm > ourout4.out

diff ourout1.out run_examples/example1.tree
diff ourout2.out run_examples/example2.tree
diff ourout3.out run_examples/example3.tree
diff ourout4.out run_examples/example-err.tree

#rm -rf ourout*