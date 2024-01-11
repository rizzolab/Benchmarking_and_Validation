# This script reads in a rank sorted list of actives and decoys and plots the ROC curve f
# database screened 
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 01/2024
# Last Edit by: Christopher Corbo
import sys,os
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import numpy as np
from sklearn import metrics
from sklearn.metrics import roc_auc_score

#plt.rcParams["font.family"]='Arial'

actives_total = float(sys.argv[1])
decoys_total = float(sys.argv[2])
system = sys.argv[3]
actives_count = 0
decoys_count = 0

one_percent = int(decoys_total / 100)

TPR = []
FPR = []
TPR_tmp = 0.000
FPR_tmp = 0.000

ranklist=[]

with open('All_score_complt_sort.txt') as file_object:
   lines = file_object.readlines()

   for line in lines:
      stripline = line.rstrip()
      splitline = stripline.split() 
      ranklist.append(splitline[1])

for i in range(len(ranklist)):
   if ranklist[i] == "Active":
      actives_count = actives_count + 1
      TPR_tmp = actives_count / actives_total

   else:
      decoys_count = decoys_count + 1
      FPR_tmp = decoys_count / decoys_total 
   #I am multiplying this by 100 to match Trents data
   TPR.append(TPR_tmp * 100)
   FPR.append(FPR_tmp * 100)

   if decoys_count == one_percent:
      EF_1 = TPR_tmp

fig,ax = plt.subplots(1)
ax.plot(FPR,TPR)

#Adding diagonal line
plt.plot([0,100],[0,100], '.',linestyle="--",color="k",linewidth=0.5)
plt.xlim([0,100])
plt.ylim([0,100])
plt.xticks([0,50,100])
plt.yticks([0,50,100])
plt.savefig(system + '_Enrichment.png')
print("AUC is " + str(np.trapz(TPR,FPR)))  
