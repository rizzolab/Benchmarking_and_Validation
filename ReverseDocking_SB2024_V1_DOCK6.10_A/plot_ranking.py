#This creates a plot of ranking output per system on 3 different metrics (cognate, protein pair match, and protein class match)
import matplotlib
import matplotlib.mlab as mlab
import numpy as np
import matplotlib.pyplot as plt

rank=[]
rank_pairs=[]
rank_class_pairs=[]
x=[]

with open("zzy.cognate_rec_rank_sort.dat","r") as filereader:
	for line in filereader:
		linestrip=line.rstrip()
		linesplit=linestrip.split()
		rank.append(float(linesplit[1]))

with open("zzy.cognate_rec_rank_w_pairs_sort.dat","r") as filereader:
	for line in filereader:
		linestrip=line.rstrip()
		linesplit=linestrip.split()
		rank_pairs.append(float(linesplit[1]))



for i in range(len(rank)):
	x.append(i)

fig, ax = plt.subplots()
ax.plot(x, rank, color='purple', alpha=1.00)
ax.plot(x, rank_pairs, color='purple', alpha=1.00,linestyle="dashed",linewidth=1.7)
ax.fill_between(x, rank, 0, color='fuchsia', alpha=.1)

plt.xlim([1,165])
plt.ylim([1,165])
plt.xticks(fontsize=16)
plt.yticks(fontsize=16)
plt.xlabel("# of systems",fontsize=16)
plt.ylabel("Rank of First Correct Protein",fontsize=16)

plt.suptitle("DOCK6 Reverse Docking",x=0.7,y=0.93,fontsize=20)

#plt.arrow(20,16,0,-9,width=1,color="k")
plt.subplots_adjust(left=0.51)
plt.show()
