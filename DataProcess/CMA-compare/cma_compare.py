#! /usr/bin/python3

import numpy as np
import matplotlib.pyplot as plt


# 读取文件A.txt的数据
#data_A = np.genfromtxt('results_cmaVSnonCma.txt', delimiter=' ')
data_A = np.genfromtxt('results_cmaVSnonCma_128.txt', delimiter=' ')
x_A = data_A[:, 8]  # nnz
y_A = data_A[:, 13]  # row/col


threshold = 1.0  


x_A_log = np.log10(x_A)




# 绘制散点图
plt.scatter(x_A_log, y_A, c='purple', s=5, label='Speedup')


plt.axhline(y=threshold, color='red', linestyle='--', label='Divide Line')


plt.xlim(0, 10)


my_x_ticks = np.arange(0, 10, 1)
my_y_ticks = np.arange(0, 10, 2)

plt.xticks(my_x_ticks)
plt.tick_params(labelsize=16)


plt.gca().set_aspect(1.08) #128
#plt.gca().set_aspect(1.2) #32


plt.xlabel('nnz of sparse matrix (log10 scale)',fontsize=20)


plt.ylabel('Speedup',fontsize=20)

#plt.savefig('speedup_col_row(32).pdf',bbox_inches='tight')
plt.savefig('speedup_col_row(128).pdf',bbox_inches='tight')