lig_sys=$1
rec_sys=$2
seed_vina_rd=$3
mkdir -p $rec_sys
cd $rec_sys

echo $lig_sys " " $rec_sys


x_tmp=`grep "npts" $testset_rd/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $2}'`
x_size=$(echo $x_tmp*0.375 | bc)
x_cent=`grep "gridcenter" $testset_rd/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $2}'`

y_tmp=`grep "npts" $testset_rd/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $3}'`
y_size=$(echo $y_tmp*0.375 | bc)
y_cent=`grep "gridcenter" $testset_rd/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $3}'`

z_tmp=`grep "npts" $testset_rd/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $4}'`
z_size=$(echo $z_tmp*0.375 | bc)
z_cent=`grep "gridcenter" $testset_rd/$rec_sys/${rec_sys}.rec.clean.gpf | awk '{print $4}'`


vina --receptor $testset_rd/$rec_sys/${rec_sys}.rec.clean.pdbqt --ligand $testset_rd/$lig_sys/${lig_sys}.lig.gast.pdbqt --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking$seed_vina_rd.log --out ${lig_sys}.vina$seed_vina_rd.pdbqt --seed_vina_rd $seed_vina_rd --num_modes 1

