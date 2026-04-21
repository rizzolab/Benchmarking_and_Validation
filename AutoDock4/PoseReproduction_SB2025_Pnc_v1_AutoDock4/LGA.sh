#!/bin/bash

testset=$1
sys=$2
cond=$3
seed=$4

mkdir $sys
cd ${sys}

#Use MGL Tools to generate docking parameter file
echo "Docking parameter file is being generated"
/gpfs/software/mgltools/bin/prepare_dpf42.py -l $testset/$sys/$sys.lig.gast.pdbqt -r $testset/$sys/$sys.rec.clean.pdbqt -o $sys.dock.parameter.dpf
input="${sys}.dock.parameter.dpf"
x=0
rm ${sys}.docking.dpf
touch ${sys}.docking.dpf

#Modify input file
while IFS= read -r line
do
    map="map"
    if [[ "$line" == *"$map"* ]]; then
        if [[ "$line" == *"fld"* ]]; then
            echo "It's a field"
            echo "fld $testset/$sys/${sys}.rec.clean.maps.fld # grid_data_file" >> ${sys}.docking.dpf
        elif [[ "$line" == *"elecmap"* ]]; then
            echo "electrostatic"
            echo "elecmap $testset/$sys/${sys}.rec.clean.e.map # electrostatics map" >> ${sys}.docking.dpf
        elif [[ "$line" == *"desolvmap"* ]]; then
            echo "desolvation"
            echo "desolvmap $testset/$sys/${sys}.rec.clean.d.map # desolvation map" >> ${sys}.docking.dpf
        else
            echo "atom type map"
               IFS=' ' read -r -a array <<< "$line"
               echo "map $testset/$sys/${array[1]}  # atom-specific affinity map" >> ${sys}.docking.dpf
               echo ${array[1]}
        fi
    elif [[ "$line" == *"move"* ]]; then
        echo "move $testset/$sys/${sys}.lig.gast.pdbqt # small molecule" >> ${sys}.docking.dpf
    else
        echo "$line" >> ${sys}.docking.dpf
    fi
    x=$(( x + 1 ))
done < "$input"
sed -i "s/pid time/${seed} ${seed}   /g" ${sys}.docking.dpf
echo "DOCKING process is occuring"

#Run the docking
autodock4 -p ${sys}.docking.dpf -l ${sys}.$cond.docking.dlg

    

