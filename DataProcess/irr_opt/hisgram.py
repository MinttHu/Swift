#! /usr/bin/python3

import matplotlib.pyplot as plt
from matplotlib import colors as mcolors
import numpy as np

#data_A = np.genfromtxt('results_optVSnonOpt.txt', delimiter=' ')
data_A = np.genfromtxt('results_optVSnonOpt_128.txt', delimiter=' ')
 
#with open('results_optVSnonOpt.txt', 'r') as file_a:
with open('results_optVSnonOpt_128.txt', 'r') as file_a:
    categories = [line.split()[0] for line in file_a]

values1 = data_A[:, 10]  # without opt
values2 = data_A[:, 12] #opt

colors1 = [(144/255, 201/255, 231/255, 1.0)] 


colors2 = [(254/255, 183/255, 5/255, 1.0)]




patter1 = [('+')]
patter2 = [('-')] 
patter3 = [('o')]
patter4 = [('*')] 
patter5 = [('x')]


plt.figure(figsize=(20, 8)) 

bar_width = 0.35
bar_positions1 = np.arange(len(categories))
bar_positions2 = bar_positions1 + bar_width
bar_positions3 = bar_positions2 + bar_width
bar_positions4 = bar_positions3 + bar_width
bar_positions5 = bar_positions4 + bar_width

plt.bar(bar_positions1, values1, color= colors1, hatch = '//', width=bar_width, edgecolor='white', label='Without Optimization')
plt.bar(bar_positions2, values2, color= colors2, hatch = 'x', width=bar_width, edgecolor='white', label='Optimization')


plt.tick_params(labelsize=15)
plt.xticks(bar_positions1 + bar_width / 2, categories,rotation=70)
plt.tick_params(labelsize=25)

plt.legend()

# 设置图形标题和轴标签
plt.legend(loc='upper right', ncol=2 ,bbox_to_anchor=(1.02, 1.24),prop = {'size':43}, facecolor='none', edgecolor='none')

plt.xlabel('Matrix Name',fontsize=35)

plt.ylabel('Time (ms)',fontsize=35)

#plt.show()
#plt.savefig('speedup_irr(32)_new.pdf',bbox_inches='tight')
plt.savefig('speedup_irr(128)_new.pdf',bbox_inches='tight')
