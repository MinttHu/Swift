#!/bin/bash
file_path="$1"

cd ../test/k-32/FP32
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/FP32

cd ../../../k-128/FP32-128
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/FP32