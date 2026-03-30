# This script will read a rank sorted list of actives and decoys and plot ROC Curves and calculate AUC and Enrichment Factor 1% values 
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 1/2024
# Last Edit by: Christopher Corbo

system="$1"
testset="$2"

cd ${system}

rm All_score_complt_sort_1*.txt

act_count=`grep MOLE $testset/zzz.DUDE_Files/$system/actives_final.mol2  |wc -l`

dec_count=`grep MOLE $testset/zzz.DUDE_Files/$system/decoys_final.mol2  |wc -l`

echo  ${system} " " >> ../Statistics.txt

v100=`wc -l All_score_complt_sort.txt | awk '{print $1}' `
v10=`echo " $v100 / 10 " | bc -l | awk -F'.' '{print $1}'`
v1=`echo " $v100 / 100 " | bc -l | awk -F'.' '{print $1}'`

head -n $v10 All_score_complt_sort.txt >All_score_complt_sort_10.txt
numd10=`grep "Decoy" All_score_complt_sort_10.txt |wc -l`
d10=`echo " $dec_count / 10 " | bc -l`
remainder=`echo " $d10 - $numd10 " | bc -l| awk -F'.' '{print $1}'`

for i in $( seq 0 $remainder );do
  echo "10000.0 Decoy" >> All_score_complt_sort_10.txt
done    

head -n $v1 All_score_complt_sort.txt >All_score_complt_sort_1.txt
numd1=`grep "Decoy" All_score_complt_sort_1.txt |wc -l`
d1=`echo " $dec_count / 100 " | bc -l`
remainder=`echo " $d1 - $numd1 " | bc -l| awk -F'.' '{print $1}'`

for i in $( seq 0 $remainder );do
  echo "10000.0 Decoy" >> All_score_complt_sort_1.txt
done

echo "1%"  >> ../Statistics.txt

python ../zzz.scripts/AUC1.py ${act_count} ${dec_count} ${system} >> ../Statistics.txt

echo "10%"  >> ../Statistics.txt

python ../zzz.scripts/AUC10.py ${act_count} ${dec_count} ${system} >> ../Statistics.txt

echo "100%"  >> ../Statistics.txt

python ../zzz.scripts/plot_roc.py ${act_count} ${dec_count} ${system} >> ../Statistics.txt
mv ${system}*.png ../plots

cd ..

