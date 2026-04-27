
ref_fam=$1
comp_sys=$2
list_of_sys="${work_dir}/zzz.family_lists/${ref_fam}.txt"

for ref_sys in `cat ${list_of_sys}`; do
cd ${ref_sys}
echo ${ref_sys}

x_tmp=`grep "npts" ${ref_sys}.rec.clean.gpf | awk '{print $2}'`
x_size=$(echo $x_tmp*0.375 | bc)
x_cent=`grep "gridcenter" ${ref_sys}.rec.clean.gpf | awk '{print $2}'`

y_tmp=`grep "npts" ${ref_sys}.rec.clean.gpf | awk '{print $3}'`
y_size=$(echo $y_tmp*0.375 | bc)
y_cent=`grep "gridcenter" ${ref_sys}.rec.clean.gpf | awk '{print $3}'`

z_tmp=`grep "npts" ${ref_sys}.rec.clean.gpf | awk '{print $4}'`
z_size=$(echo $z_tmp*0.375 | bc)
z_cent=`grep "gridcenter" ${ref_sys}.rec.clean.gpf | awk '{print $4}'`



vina --receptor ../../${ref_sys}.rec.clean.pdbqt --ligand ../../${comp_sys}.lig.gast.pdbqt --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking$seed.log --out ${comp_sys}_${ref_sys}.vina$seed.pdbqt --seed $seed --num_modes 100

echo "vina --receptor ${ref_sys}.rec.clean.pdbqt --ligand ${comp_sys}.lig.gast.pdbqt --center_x $x_cent --size_x $x_size --center_y $y_cent --size_y $y_size --center_z $z_cent --size_z $z_size  --log docking$seed.log --out ${comp_sys}_${ref_sys}.vina$seed.pdbqt --seed $seed --num_modes 100" >> docking_rerun$seed.log

cd ../
done
