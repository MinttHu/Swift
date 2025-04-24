#!/bin/bash

cd ../src
./test -d 0 ../MTX_samples/bundle1.mtx
./test -d 0 ../MTX_samples/c-48.mtx
./test -d 0 ../MTX_samples/HEP-th.mtx
./test -d 0 ../MTX_samples/rajat22.mtx
./test -d 0 ../MTX_samples/RFdevice.mtx

cd ../test/k-32/CMA-compare

./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../FP32
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../FP64
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../idealCMA
./test -d 0 ../../../MTX_samples/bundle1.mtx

cd ../irr_opt
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../irr_regular_ratio
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../preprocess
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../../k-128/CMA-compare-128

./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../FP32-128
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../FP64-128
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx

cd ../idealCMA-128
./test -d 0 ../../../MTX_samples/bundle1.mtx

cd ../irr_opt-128
./test -d 0 ../../../MTX_samples/bundle1.mtx
./test -d 0 ../../../MTX_samples/c-48.mtx
./test -d 0 ../../../MTX_samples/HEP-th.mtx
./test -d 0 ../../../MTX_samples/rajat22.mtx
./test -d 0 ../../../MTX_samples/RFdevice.mtx




