
sys=$1
echo $sys
mkdir $sys
cd $sys

cp $testset/$sys/$sys.rec.clean.gpf ./
cp $testset/$sys/$sys.rec.clean.pdbqt ./
cp $testset/$sys/$sys.lig.gast.pdbqt ./

x_tmp=`grep "npts" ${sys}.rec.clean.gpf | awk '{print $2}'`
x_size=$(echo $x_tmp*0.375 | bc)
x_cent=`grep "gridcenter" ${sys}.rec.clean.gpf | awk '{print $2}'`

y_tmp=`grep "npts" ${sys}.rec.clean.gpf | awk '{print $3}'`
y_size=$(echo $y_tmp*0.375 | bc)
y_cent=`grep "gridcenter" ${sys}.rec.clean.gpf | awk '{print $3}'`

z_tmp=`grep "npts" ${sys}.rec.clean.gpf | awk '{print $4}'`
z_size=$(echo $z_tmp*0.375 | bc)
z_cent=`grep "gridcenter" ${sys}.rec.clean.gpf | awk '{print $4}'`


vina --receptor ${sys}.rec.clean.pdbqt --ligand ${sys}.lig.gast.pdbqt --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking${seed}.log --exhaustiveness 8 --out ${sys}.vina.$conditions.pdbqt --seed $seed --num_modes 20 --cpu 1 

echo "vina --receptor ${sys}.rec.clean.pdbqt --ligand ${sys}.lig.gast.pdbqt --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking${seed}.log --exhaustiveness 8 --out ${sys}.vina.$conditions.pdbqt --seed $seed --num_modes 20 --cpu 1" > vina_$conditions.out
