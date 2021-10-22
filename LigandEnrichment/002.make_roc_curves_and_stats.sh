# This script will read a rank sorted list of actives and decoys and plot ROC Curves and calculate AUC and Enrichment Factor 1% values 
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 10/2021
# Last Edit by: Christopher Corbo
system_file="Completed_DUDE.txt"
mkdir plots
for system in `cat ${system_file}`; do

   cd ${system}

   act_count=`grep -wc "Active" All_score_sort.txt`
   dec_count=`grep -wc "Decoy" All_score_sort.txt`
   echo -n ${system} " " >> ../Statistics.txt
   python ../plot_roc.py ${act_count} ${dec_count} ${system} >> ../Statistics.txt
   mv ${system}*.png ../plots

   cd ..
done

