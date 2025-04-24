#! /usr/bin/python3

import numpy as np
import matplotlib.pyplot as plt


#data_C = np.genfromtxt('ideal-cma.txt', delimiter=' ')
data_C = np.genfromtxt('ideal-cma-128.txt', delimiter=' ')


x_C = data_C[:, 8]
y_A = data_C[:, 13]


threshold = 1.0  


x_C_log = np.log10(x_C)

y_A_log = np.log10(y_A)



plt.scatter(x_C_log, y_A, c='purple', s=25)


plt.xlim(6, 9)

plt.tick_params(labelsize=20)

plt.xlabel('M x K (log10 scale)',fontsize=22)

plt.ylabel('Speedup',fontsize=23)


#plt.savefig('motivation_speedup_32.pdf',bbox_inches='tight')
plt.savefig('motivation_speedup_128.pdf',bbox_inches='tight')
