#!/bin/bash
file_path="$1"

cd ../test/k-32/FP64
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/FP64

cd ../../../k-128/FP64-128
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/FP64