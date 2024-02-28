#!/bin/sh
#SBATCH --partition=long-28core
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --job-name=Whaddup
#SBATCH --output=boop
for lig_sys in `cat FARMA.systems.all`;do
cd $lig_sys
rm tmp_scores.txt
for sys in `cat ../FARMA.systems.all `;do
val=`grep Grid_Score ${lig_sys}_${sys}_0_scored.mol2| head -n1`
echo $sys " " $val >> tmp_scores.txt
done
rank=`sort -n -k4  tmp_scores.txt| grep -n $lig_sys| awk -F ':' '{print $1}'`
echo $lig_sys " " $rank >> ../zzy.cognate_rec_rank.dat
cd ..
done
