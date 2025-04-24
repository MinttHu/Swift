#!/bin/bash
file_path="$1"

cd ../test/k-32/irr_regular_ratio
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/irr_regular_ratio

