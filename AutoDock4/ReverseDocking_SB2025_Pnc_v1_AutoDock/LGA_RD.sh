#!/bin/bash
lig_sys=$1
rec_sys=$2
seed=$3

echo "Running: " ${lig_sys} " " $rec_sys
mkdir ${rec_sys}
cd ${rec_sys}
#This will be used to create the docking parameter file and to make modification to the docking parameters follow the comments for prepare_gpf4.py
echo "Docking parameter file is being generated"
/gpfs/software/mgltools/bin/prepare_dpf42.py -l ${testset}/${lig_sys}/${lig_sys}.lig.gast.pdbqt -r ${testset}/${rec_sys}/${rec_sys}.rec.clean.pdbqt -o ${rec_sys}.dock.parameter.dpf
sed -i '2i parameter_file /gpfs/projects/rizzo/ccorbo/Testing_Grounds/AutoDock/PoseReprod_Autodock/AD4_parameters_with_Na_K.dat # force field default parameter file' ${rec_sys}.dock.parameter.dpf
input="${rec_sys}.dock.parameter.dpf"
x=0
rm ${rec_sys}.docking.dpf
touch ${rec_sys}.docking.dpf
while IFS= read -r line
do
        #echo "$line"
    map="map"
    if [[ "$line" == *"$map"* ]]; then
        if [[ "$line" == *"fld"* ]]; then
            echo "It's a field"
            echo "fld ${testset}/${rec_sys}/${lig_sys}_${rec_sys}.rec.clean.maps.fld # grid_data_file" >> ${rec_sys}.docking.dpf
        elif [[ "$line" == *"elecmap"* ]]; then
            echo "electrostatic"
            echo "elecmap ${testset}/${rec_sys}/${rec_sys}.rec.clean.e.map # electrostatics map" >> ${rec_sys}.docking.dpf
        elif [[ "$line" == *"desolvmap"* ]]; then
            echo "desolvation"
            echo "desolvmap ${testset}/${rec_sys}/${rec_sys}.rec.clean.d.map # desolvation map" >> ${rec_sys}.docking.dpf
        else
            echo "atom type map"
               IFS=' ' read -r -a array <<< "$line"
               echo "map ${testset}/${rec_sys}/${array[1]}  # atom-specific affinity map" >> ${rec_sys}.docking.dpf
               echo ${array[1]}
        fi
    elif [[ "$line" == *"move"* ]]; then
        echo "move ${testset}/${lig_sys}//${lig_sys}.lig.gast.pdbqt # small molecule" >> ${rec_sys}.docking.dpf
    else
        echo "$line" >> ${rec_sys}.docking.dpf
    fi
    x=$(( x + 1 ))
done < "$input"
sed -i "s/pid time/${seed} ${seed}   /g" ${rec_sys}.docking.dpf
echo "DOCKING process is occuring"
autodock4 -p ${rec_sys}.docking.dpf -l ${rec_sys}.docking.dlg
summarize_results4.py -d ./


