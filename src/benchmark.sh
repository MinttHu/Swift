#!/bin/bash

# 运行第一个.sh文件
./eval_spmm.sh -> check.txt

# 检查第一个.sh文件是否成功完成
if [ $? -eq 0 ]; then
  echo "finished" >> check/schedule.txt
else
  echo "failed" >> check/schedule.txt
fi

