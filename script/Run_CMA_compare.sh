#!/bin/bash
file_path="$1"

cd ../test/k-32/CMA-compare
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/CMA-compare

cd ../../../k-128/CMA-compare-128
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/CMA-compare