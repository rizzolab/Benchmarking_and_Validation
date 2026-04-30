#!/bin/bash
ligand=$1
sys=$2
lig_set=$3

dock_dir=$4
cd $dock_dir


x_tmp=`grep "npts" ../${sys}.rec.clean.gpf | awk '{print $2}'`
x_size=$(echo $x_tmp*0.375 | bc)
x_cent=`grep "gridcenter" ../${sys}.rec.clean.gpf | awk '{print $2}'`

y_tmp=`grep "npts" ../${sys}.rec.clean.gpf | awk '{print $3}'`
y_size=$(echo $y_tmp*0.375 | bc)
y_cent=`grep "gridcenter" ../${sys}.rec.clean.gpf | awk '{print $3}'`

z_tmp=`grep "npts" ../${sys}.rec.clean.gpf | awk '{print $4}'`
z_size=$(echo $z_tmp*0.375 | bc)
z_cent=`grep "gridcenter" ../${sys}.rec.clean.gpf | awk '{print $4}'`


vina --receptor ../${sys}.rec.clean.pdbqt --ligand ../${ligand} --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking${seed}.log --exhaustiveness 8 --out ${ligand}.vina.pdbqt --seed 1 --num_modes 1 --cpu 1 

echo "vina --receptor ../${sys}.rec.clean.pdbqt --ligand ../${ligand} --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking${seed}.log --exhaustiveness 8 --out ${ligand}.vina.pdbqt --seed $seed --num_modes 1 --cpu 1" >>$ligand.out

tmp_score=`grep "REMARK VINA RESULT" ${ligand}.vina.pdbqt |awk '{print $4}'`

echo $lig_set " " $tmp_score >> ${lig_set}_score_list.txt
