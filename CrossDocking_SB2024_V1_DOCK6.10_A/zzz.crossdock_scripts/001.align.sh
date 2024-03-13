#!/bin/sh

# This script will use the mmaker function in Chimera to align all receptors in a family along their backbones
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 01/2024
# Last Edit by: Christopher Corbo
module load chimera/1.13.1

testset="$1"

family_list="${LIST_DIR}/zzz.Families.txt"

mkdir Alignment
cd Alignment
# Aligns each family one at a time to its respective reference system
for family in `cat $family_list`;do
echo $family
mkdir ${family}
cd ${family}
mkdir mol2

list="${LIST_DIR}/${family}.txt"

# All proteins in the family will be aligned to whichever PDB is first in the given list
ref=`head -n1 $list`

for system in `cat $list`; do
echo $system
mkdir ${system}
cd ${system}
# Chimera commands script to align proteins and apply same transformation to ligands and rewrite the files with new coordinates
##############################################
cat >  chimera.com <<EOF
open $testset/$ref/$ref.rec.clean.mol2
open $testset/$system/$system.rec.clean.mol2
open $testset/$system/$system.lig.am1bcc.mol2
mmaker #0 #1 pair ss ss false iter 2.0
matrixcopy #1 #2 
write format pdb  1 ${system}.rec.foramber.pdb
write format mol2 2 ${system}.lig.moe.mol2
EOF
#############################################
chimera --nogui chimera.com >& chimera.out

cp ${system}.rec.foramber.pdb ${BUILD_DIR}/zzz.master
cp ${system}.lig.moe.mol2 ${BUILD_DIR}/zzz.master


mv ${system}.rec.foramber.pdb ../mol2
mv ${system}.lig.moe.mol2 ../mol2

cd .. #Back to family subdirectory
done # foreach system


cd .. #Back to top directory
done # foreach family

