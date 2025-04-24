#!/bin/bash

targets=(
  src
  test/k-32/CMA-compare
  test/k-32/FP32
  test/k-32/FP64
  test/k-32/idealCMA
  test/k-32/irr_opt
  test/k-32/irr_regular_ratio
  test/k-32/preprocess
  test/k-128/CMA-compare-128
  test/k-128/FP32-128
  test/k-128/FP64-128
  test/k-128/idealCMA-128
  test/k-128/irr_opt-128
  test/k-128/irr_regular_ratio-128
  test/k-128/preprocess-128
)

#Uncomment the following three lines of code.

#for dir in "${targets[@]}"; do
#  cp Makefile "$dir"
#done

#k=32


cd src
make

cd ../test/k-32/CMA-compare
make

cd ../FP32
make

cd ../FP64
make

cd ../idealCMA
make

cd ../irr_opt
make

cd ../irr_regular_ratio
make

cd ../preprocess
make

#k=128
cd ../../k-128/CMA-compare-128
make

cd ../FP32-128
make

cd ../FP64-128
make

cd ../idealCMA-128
make

cd ../irr_opt-128
make






