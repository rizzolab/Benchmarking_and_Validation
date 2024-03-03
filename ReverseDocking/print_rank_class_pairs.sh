#!/bin/sh
#SBATCH --partition=rn-long-40core
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --job-name=print_rank_class
#SBATCH --output=print_rank_class.out
for lig_sys in `cat FARMA.systems.all`;do
cd $lig_sys
rm tmp_scores_classpairs.txt
for sys in `cat ../FARMA.systems.all `;do
val=`grep Grid_Score ${lig_sys}_${sys}_0_scored.mol2| head -n1`
echo $sys " " $val >> tmp_scores_classpairs.txt
done

pairs=`grep $lig_sys ../../FARMA_class_pairs.dat `
best_pair=`for pair in echo $pairs;do grep $pair tmp_scores_classpairs.txt ;done | sort -n -k4 | head -n1 | awk '{print $1}'`

rank=`sort -n -k4  tmp_scores_classpairs.txt| grep -n $best_pair | awk -F ':' '{print $1}'`
echo $lig_sys " " $rank >> ../zzy.cognate_rec_rank_w_class_pairs.dat
cd ..
done