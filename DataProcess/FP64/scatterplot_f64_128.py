#! /usr/bin/python3

import numpy as np
import matplotlib.pyplot as plt



data_A = np.genfromtxt('result__spmm_f64_n128.txt', delimiter=' ')
data_B = np.genfromtxt('result_ASpT_spmm_f64_n128.txt', delimiter=' ')
data_C = np.genfromtxt('results_spmm_f64_128.txt', delimiter=' ')


x_A = data_A[:, 3]  
  


y_B = data_A[:, 4]


y_C = data_A[:, 6]

y_D = data_A[:, 8]

x_E = data_B[:, 3]
y_E = data_B[:, 4]

x_C = data_C[:, 8]
y_A = data_C[:, 16]

threshold = 1.0 


x_A_log = np.log10(x_A)
x_E_log = np.log10(x_E)

x_C_log = np.log10(x_C)

y_A_log = np.log10(y_A)
y_B_log = np.log10(y_B)
y_C_log = np.log10(y_C)
y_D_log = np.log10(y_D)
y_E_log = np.log10(y_E)



plt.scatter(x_E_log, y_E_log, c='pink', s=5, label='ASpT')
plt.scatter(x_A_log, y_C_log, c='yellow', s=5, label='cuSPARSE')
plt.scatter(x_A_log, y_D_log, c='black', s=5, label='RoDe')
plt.scatter(x_A_log, y_B_log, c='blue', s=5, label='Spuntik')
plt.scatter(x_C_log, y_A_log, c='red', s=5, label='Swift')




plt.tick_params(labelsize=20)

plt.legend(prop = {'size':12})


plt.xlabel('nnz of sparse matrix (log10 scale)',fontsize=20)

plt.ylabel('Time (ms, log10 scale)',fontsize=20)


plt.savefig('timecompare_full_f64_n128.png',bbox_inches='tight')
