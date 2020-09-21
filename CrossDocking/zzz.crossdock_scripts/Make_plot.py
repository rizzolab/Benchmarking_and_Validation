import sys
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import ListedColormap


inputfilename = sys.argv[1]
filelist = []

#This will read a list of the actual lists containing data's names which will be used to call these individual files
file_name = 'inputfilename'
with open(inputfilename) as file_object:
   lines = file_object.readlines()
for line in lines:
   value = line.rstrip()
   filelist.append(value)

#This creates a list of all the individual sublists by appending individual lists first and then appending these inner lists to the outer list
megalist = []
for i in range(len(filelist)): # This loop specifies which list is being read
   datalist = []
   filename = (filelist[i] + ".outcome.txt")
   with open(filename) as file_object:
      lines = file_object.readlines()
   for line in lines:
      value = line.rstrip()
      value = int(value)
      datalist.append(value)
   megalist.append(datalist)
print(len(megalist))
mat = megalist
##########################################
N = len(megalist)


##########################################

cmap = ListedColormap(['#A0A0A0','r','g','b'])

line = mat

# Make a NxN grid...
nrows, ncols = N,N

image = np.array(line)
# Reshape things into a NxN grid.
image = image.reshape((nrows, ncols))
image = np.transpose(image)
row_labels = filelist
col_labels = filelist
plt.matshow(image,cmap=cmap,vmin=0,vmax=3)
plt.xticks(range(ncols), col_labels, rotation = 90)
plt.yticks(range(nrows), row_labels)
ax = plt.gca();
ax.set_xticks(np.arange(-.5, N, 1), minor=True);
ax.set_yticks(np.arange(-.5, N, 1), minor=True);
x=[]
y=[]
for i in range(N):
	x.append(i)
	y.append(i)
plt.plot(x,y,'k.')
# Gridlines based on minor ticks
ax.grid(which='minor', color='k', linestyle='-', linewidth=1)
plt.savefig("heatmap.png")

