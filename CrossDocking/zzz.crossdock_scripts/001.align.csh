#!/bin/tcsh

# This script will use the mmaker function in Chimera to align all receptors in a family along their backbones
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 02/2021
# Last Edit by: Christopher Corbo
module load chimera/1.13.1


set testset = "/gpfs/projects/rizzo/ccorbo/Building_Stuff/DOCK6_with_ambpdb/SB_2020_testset"

set family_list="${LIST_DIR}/family_more_than7.txt"

# Aligns each family one at a time to its respective reference system
foreach family (`cat $family_list`)
mkdir ${family}
cd ${family}

set list = "${LIST_DIR}/${family}.txt"

# All proteins in the family will be aligned to whichever PDB is first in the given list
set ref  = `head -1 $list`

foreach system (`cat $list`)
mkdir ${system}
cd ${system}
# Chimera commands script to align proteins and apply same transformation to ligands and rewrite the files with new coordinates
##############################################
cat << EOF > chimera.com
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

mv ${system}.rec.foramber.pdb ${BUILD_DIR}/zzz.master
mv ${system}.lig.moe.mol2 ${BUILD_DIR}/zzz.master

cd .. #Back to family subdirectory
end # foreach system

rm -r ${system}

cd .. #Back to top directory

rm -r ${family}
end # foreach family

