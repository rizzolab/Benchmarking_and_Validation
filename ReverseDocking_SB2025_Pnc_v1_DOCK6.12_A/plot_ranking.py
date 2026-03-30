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

with open("zzy.cognate_rec_rank_w_class_pairs_sort.dat","r") as filereader:
	for line in filereader:
		linestrip=line.rstrip()
		linesplit=linestrip.split()
		rank_class_pairs.append(float(linesplit[1]))


for i in range(len(rank)):
	x.append(i)

fig, ax = plt.subplots()
ax.plot(x, rank, color='black', alpha=1.00,linewidth=1.15)
ax.plot(x, rank_pairs, color='black', alpha=1.00,linestyle="dashed",linewidth=1.6)
ax.plot(x, rank_class_pairs, color='black', alpha=1.00,linestyle="dotted",linewidth=1.75)
ax.fill_between(x, rank, 0, color='salmon', alpha=.2)

ax.set_aspect('equal', adjustable='box')   # makes the plot square
ax.set_xticks(np.arange(0, 181, 20))       # x-axis intervals of 20
ax.set_yticks(np.arange(0, 181, 20))       # y-axis intervals of 20

plt.xlim([1,165])
plt.ylim([1,165])
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.xlabel("# of systems",fontsize=14.5)
plt.ylabel("Rank of First Correct Protein",fontsize=14.5)

#plt.suptitle("DOCK6 Reverse Docking",x=0.7,y=0.93,fontsize=20)

#plt.arrow(20,16,0,-9,width=1,color="k")
plt.tight_layout()
plt.savefig("2025_07_23_DOCK6_RD.pdf")
