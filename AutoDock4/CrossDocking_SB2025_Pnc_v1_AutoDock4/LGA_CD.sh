#!/bin/bash
ref_fam=$1
comp_sys=$2
list_of_sys="${work_dir}/zzz.family_lists/${ref_fam}.txt"

for ref_sys in `cat ${list_of_sys}`; do
cd ${ref_sys}
echo ${ref_sys}
#This will be used to create the docking parameter file and to make modification to the docking parameters follow the comments for prepare_gpf4.py
echo "Docking parameter file is being generated with ligand ${comp_sys} and receptor ${ref_sys}"
/gpfs/software/mgltools/bin/prepare_dpf42.py -l ../../${comp_sys}.lig.gast.pdbqt -r ../../${ref_sys}.rec.clean.pdbqt -o ${ref_sys}.dock.parameter.dpf
sed -i "2i parameter_file ${work_dir}/AD4_parameters_with_Na_K.dat # force field default parameter file" ${ref_sys}.dock.parameter.dpf
input="${ref_sys}.dock.parameter.dpf"
x=0
rm ${ref_sys}.docking.dpf
touch ${ref_sys}.docking.dpf
     while IFS= read -r line
     do
             #echo "$line"
         map="map"
         if [[ "$line" == *"$map"* ]]; then
             if [[ "$line" == *"fld"* ]]; then
                 echo "It's a field"
                 echo "fld ${ref_sys}.rec.clean.maps.fld # grid_data_file" >> ${ref_sys}.docking.dpf
             elif [[ "$line" == *"elecmap"* ]]; then
                 echo "electrostatic"
                 echo "elecmap ${ref_sys}.rec.clean.e.map # electrostatics map" >> ${ref_sys}.docking.dpf
             elif [[ "$line" == *"desolvmap"* ]]; then
                 echo "desolvation"
                 echo "desolvmap ${ref_sys}.rec.clean.d.map # desolvation map" >> ${ref_sys}.docking.dpf
             else
                 echo "atom type map"
                    IFS=' ' read -r -a array <<< "$line"
                    echo "map ${array[1]}  # atom-specific affinity map" >> ${ref_sys}.docking.dpf
                    echo ${array[1]}
             fi
         elif [[ "$line" == *"move"* ]]; then
             echo "move ../../${comp_sys}.lig.gast.pdbqt # small molecule" >> ${ref_sys}.docking.dpf
         else
             echo "$line" >> ${ref_sys}.docking.dpf
         fi
         x=$(( x + 1 ))
     done < "$input"
     sed -i 's/pid time/3 3      /g' ${ref_sys}.docking.dpf
     echo "DOCKING process is occuring"
     grep "move" ${ref_sys}.docking.dpf
     autodock4 -p ${ref_sys}.docking.dpf -l ${ref_sys}.docking.dlg
     cd ..
done
