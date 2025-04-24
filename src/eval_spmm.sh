#!/bin/bash


filenames=$(cat test_mtx_list.txt)
#filenames=$(cat ufl_matricesV3.txt)

for filename in $filenames; do
    ./test -d 1 ../MTX/$filename.mtx
done