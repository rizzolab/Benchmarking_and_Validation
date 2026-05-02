#!/bin/sh
#SBATCH --partition=
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --job-name=AD4_RD_002
#SBATCH --output=AD4_RD_002.out

#This script determines how well the ligand from each system ranked it's correct protein target at 3 classification levels
#Cognate, Protein Family, Protein Class
#Cognate ranking
cd FARMA2025_V1

for lig_sys in `cat $work_dir/FARMA.systems.all`;do
  cd $lig_sys
  rm tmp_scores_cognate*
  for sys in `cat $work_dir/FARMA.systems.all `;do
    cd $sys
    val=`awk '{print $2}' summary_of_results_1.0 | grep -v "#" | head -n1 | tr -d  ','`
    cd ../
    echo $sys " " $val >> tmp_scores_cognate.txt
  done
  sort -n -k2 tmp_scores_cognate.txt  > tmp_scores_cognate_sort.txt 
  val=`sort -n -k2  tmp_scores_cognate.txt| grep $lig_sys | awk '{print $2}'`
  rank=`grep -n -e $val tmp_scores_cognate_sort.txt | head -n1 | awk -F ':' '{print $1}'`
  echo $lig_sys " " $rank >> $work_dir/zzy.cognate_rec_rank.dat
  cd ..
done
#Protein Family
for lig_sys in `cat $work_dir/FARMA.systems.all`;do
  cd $lig_sys
  rm tmp_scores_fam*
  for sys in `cat $work_dir/FARMA.systems.all `;do
    cd $sys
    val=`awk '{print $2}' summary_of_results_1.0 | grep -v "#" | head -n1 | tr -d  ','`
    cd ../
    echo $sys " " $val >> tmp_scores_fam.txt
  done
  sort -n -k2 tmp_scores_fam.txt  > tmp_scores_fam_sort.txt 

  pairs=`grep $lig_sys $work_dir/FARMA_pairs.dat `
  echo $pairs
  best_pair=`for pair in echo $pairs;do grep $pair tmp_scores_fam.txt ;done | sort -n -k2 | head -n1 | awk '{print $1}'`

  val=`sort -n -k2  tmp_scores_fam.txt| grep $best_pair | awk '{print $2}'`

  rank=`grep -n -e $val tmp_scores_fam_sort.txt | head -n1 | awk -F ':' '{print $1}'`

  echo $lig_sys " " $rank >> $work_dir/zzy.family_rec_rank.dat
  cd ..
done
#Protein Class
for lig_sys in `cat $work_dir/FARMA.systems.all`;do
  cd $lig_sys
  rm tmp_scores_class*
  for sys in `cat $work_dir/FARMA.systems.all `;do
    cd $sys
    val=`awk '{print $2}' summary_of_results_1.0 | grep -v "#" | head -n1 | tr -d  ','`
    cd ../
    echo $sys " " $val >> tmp_scores_class.txt
  done
  sort -n -k2 tmp_scores_class.txt  > tmp_scores_class_sort.txt 

  pairs=`grep $lig_sys $work_dir/FARMA_class_pairs.dat `
  echo $pairs
  best_pair=`for pair in echo $pairs;do grep $pair tmp_scores_class.txt ;done | sort -n -k2 | head -n1 | awk '{print $1}'`

  val=`sort -n -k2  tmp_scores_class.txt| grep $best_pair | awk '{print $2}'`

  rank=`grep -n -e $val tmp_scores_class_sort.txt | head -n1 | awk -F ':' '{print $1}'`

  echo $lig_sys " " $rank >> $work_dir/zzy.classily_rec_rank.dat
  cd ..
done

cd ..

sort -n -k2 zzy.cognate_rec_rank.dat > zzy.cognate_rec_rank_sort.dat
sort -n -k2 zzy.family_rec_rank.dat > zzy.family_rec_rank_sort.dat
sort -n -k2 zzy.classily_rec_rank.dat > zzy.classily_rec_rank_sort.dat
