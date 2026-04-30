# This script will read a rank sorted list of actives and decoys and plot ROC Curves and calculate AUC and Enrichment Factor 1% values 
# Written by: C Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 10/2021
# Last Edit by: C Corbo
system_file="DUDE.systems.all"
for sys in `cat ${system_file}`; do
sys=3CCW

   cd ${sys}

   rm All_score_complt_sort_1.txt
   rm All_score_complt_sort_10.txt
   
   act_count=`grep "${sys}" ../Total_LE_Actives.txt| awk '{print $1}'`

   dec_count=`grep "${sys}" ../Total_LE_Decoys.txt| awk '{print $1}'`
   #act_count=`grep -wc "active" All_score_sort.txt`
   #dec_count=`grep -wc "Decoy" All_score_sort.txt`

   echo  ${sys} " " >> ../Statistics.txt

   v100=`wc -l All_score_complt_sort.txt | awk '{print $1}' `
   v10=`echo " $v100 / 10 " | bc -l | awk -F'.' '{print $1}'`
   v1=`echo " $v100 / 100 " | bc -l | awk -F'.' '{print $1}'`

   head -n $v10 All_score_complt_sort.txt >All_score_complt_sort_10.txt
   numd10=`grep "decoy" All_score_complt_sort_10.txt |wc -l`
   d10=`echo " $dec_count / 10 " | bc -l`
   remainder=`echo " $d10 - $numd10 " | bc -l| awk -F'.' '{print $1}'`


   for i in $( seq 0 $remainder );do
   echo "decoy 10000.0" >> All_score_complt_sort_10.txt
   done    

   head -n $v1 All_score_complt_sort.txt >All_score_complt_sort_1.txt
   numd1=`grep "decoy" All_score_complt_sort_1.txt |wc -l`
   d1=`echo " $dec_count / 100 " | bc -l`
   remainder=`echo " $d1 - $numd1 " | bc -l| awk -F'.' '{print $1}'`

   for i in $( seq 0 $remainder );do
   echo "decoy 10000.0" >> All_score_complt_sort_1.txt
   done

   echo "1%"  >> ../Statistics.txt

   python ../zzz.scripts/AUC1.py ${act_count} ${dec_count} ${sys} >> ../Statistics.txt

   echo "10%"  >> ../Statistics.txt

   python ../zzz.scripts/AUC10.py ${act_count} ${dec_count} ${sys} >> ../Statistics.txt

   echo "100%"  >> ../Statistics.txt

   python ../zzz.scripts/plot_roc.py ${act_count} ${dec_count} ${sys} >> ../Statistics.txt
   mv ${sys}*.pdf ../plots

   cd ..
done
