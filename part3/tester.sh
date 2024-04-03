#!/bin/bash

make clean
make

# compile all the examples
echo "compiling example1"
./rx-cc ./examples/example1.cmm
echo "compiling example2"
./rx-cc ./examples/example2.cmm
echo "compiling example3"
./rx-cc ./examples/example3-main.cmm
./rx-cc ./examples/example3-funcs.cmm
echo "compiling example4"
./rx-cc ./examples/example4.cmm
echo "compiling example5"
./rx-cc ./examples/example5.cmm
echo "compiling example6"
./rx-cc ./examples/example6.cmm
echo "compiling ourexample1"
./rx-cc ./examples/ourexample1.cmm
echo "compiling ourexample2"
./rx-cc ./examples/ourexample2.cmm
echo "compiling ourexample3"
./rx-cc ./examples/ourexample3.cmm

# link and run the examples one by one
./rx-linker example1.rsk
./rx-vm out.e
./rx-linker example2.rsk
./rx-vm out.e
./rx-linker example3-main.rsk example3-funcs.rsk
./rx-vm out.e
./rx-linker example4.rsk
./rx-vm out.e
./rx-linker example6.rsk
./rx-vm out.e
./rx-linker ourexample1.rsk
./rx-vm out.e
./rx-linker ourexample2.rsk
./rx-vm out.e
./rx-linker ourexample3.rsk
./rx-vm out.e