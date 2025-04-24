#!/bin/bash
file_path="$1"

cd ../test/k-32/idealCMA
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/idealCMA

cd ../../../k-128/idealCMA-128
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/idealCMA