#!/bin/bash
ligand=$1
system=$2
lig_set=$3

dock_dir=$4
cd $dock_dir

#This will be used to create the docking parameter file and to make modification to the docking parameters follow the comments for prepare_gpf4.py
echo "Docking parameter file is being generated with ligand ${ligand} and receptor ${system}"
/gpfs/software/mgltools/bin/prepare_dpf42.py -l ../${ligand} -r ../${system}.rec.clean.pdbqt -o ${ligand}.dock.parameter.dpf
sed -i '2i parameter_file /gpfs/projects/rizzo/ccorbo/Testing_Grounds/AutoDock/PoseReprod_Autodock/AD4_parameters_with_Na_K.dat # force field default parameter file' ${ligand}.dock.parameter.dpf
input="${ligand}.dock.parameter.dpf"
x=0
rm ${ligand}.docking.dpf
touch ${ligand}.docking.dpf
     while IFS= read -r line
     do
             #echo "$line"
         map="map"
         if [[ "$line" == *"$map"* ]]; then
             if [[ "$line" == *"fld"* ]]; then
                 echo "It's a field"
                 echo "fld ../${system}.rec.clean.maps.fld # grid_data_file" >> ${ligand}.docking.dpf
             elif [[ "$line" == *"elecmap"* ]]; then
                 echo "electrostatic"
                 echo "elecmap ../${system}.rec.clean.e.map # electrostatics map" >> ${ligand}.docking.dpf
             elif [[ "$line" == *"desolvmap"* ]]; then
                 echo "desolvation"
                 echo "desolvmap ../${system}.rec.clean.d.map # desolvation map" >> ${ligand}.docking.dpf
             else
                 echo "atom type map"
                    IFS=' ' read -r -a array <<< "$line"
                    echo "map ../${array[1]}  # atom-specific affinity map" >> ${ligand}.docking.dpf
                    echo ${array[1]}
             fi
         elif [[ "$line" == *"move"* ]]; then
             echo "move ../${ligand} # small molecule" >> ${ligand}.docking.dpf
         else
             echo "$line" >> ${ligand}.docking.dpf
         fi
         x=$(( x + 1 ))
     done < "$input"
     sed -i 's/pid time/3 3      /g' ${ligand}.docking.dpf
     echo "DOCKING process is occuring"
     grep "move" ${ligand}.docking.dpf
     autodock4 -p ${ligand}.docking.dpf -l ${ligand}.docking.dlg

     #Only retain lowest scoring energy
     tmp_score=`grep -A4 "Lowest" $ligand.docking.dlg | tail -n1 | awk '{print $3}'`
     # record whether its an active or decoy and the score
     echo $lig_set " " $tmp_score  >> ${lig_set}_score_list.txt

     #rm ${ligand}.docking.dlg
     #rm ${ligand}.docking.dpf
     #rm ${ligand}.dock.parameter.dpf
