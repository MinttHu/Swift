#!/bin/bash
file_path="$1"

cd ../test/k-32/preprocess
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/preprocess