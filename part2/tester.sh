#!/bin/bash

make clean
make
./part2 < input_files/example1.cmm > ourout1.out
./part2 < input_files/example2.cmm > ourout2.out
./part2 < input_files/example3.cmm > ourout3.out
./part2 < input_files/example4.cmm > ourout4.out
./part2 < input_files/example5.cmm > ourout5.out
./part2 < input_files/example-err.cmm > ourout6.out

diff -s -q ourout1.out output_files/example1.tree
diff -s -q ourout2.out output_files/example2.tree
diff -s -q ourout3.out output_files/example3.tree
diff -s -q ourout4.out output_files/example4.tree
diff -s -q ourout5.out output_files/example5.tree
diff -s -q ourout6.out output_files/example-err.tree

#rm -rf ourout*