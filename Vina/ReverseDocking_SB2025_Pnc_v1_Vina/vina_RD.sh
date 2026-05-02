lig_sys=$1
rec_sys=$2
seed=$3
mkdir $rec_sys
cd $rec_sys

echo $lig_sys " " $rec_sys


x_tmp=`grep "npts" $testset/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $2}'`
x_size=$(echo $x_tmp*0.375 | bc)
x_cent=`grep "gridcenter" $testset/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $2}'`

y_tmp=`grep "npts" $testset/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $3}'`
y_size=$(echo $y_tmp*0.375 | bc)
y_cent=`grep "gridcenter" $testset/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $3}'`

z_tmp=`grep "npts" $testset/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $4}'`
z_size=$(echo $z_tmp*0.375 | bc)
z_cent=`grep "gridcenter" $testset/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $4}'`


vina --receptor $testset/$rec_sys/${rec_sys}.rec.clean.pdbqt --ligand $testset/$lig_sys/${lig_sys}.lig.gast.pdbqt --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking$seed.log --out ${lig_sys}.vina$seed.pdbqt --seed $seed --num_modes 1

