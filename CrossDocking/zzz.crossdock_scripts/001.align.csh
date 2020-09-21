#!/bin/tcsh
module load chimera/1.13.1


set testset = "/gpfs/projects/rizzo/yuchzhou/RCR/DOCK_testset"

set family_list="${LIST_DIR}/family_more_than7.txt"

foreach family (`cat $family_list`)
mkdir ${family}
cd ${family}

set list = "/gpfs/projects/rizzo/ccorbo/test_set/${family}.txt"

set ref  = `head -1 $list`

foreach system (`cat $list`)
mkdir ${system}
cd ${system}
##############################################
cat << EOF > chimera.com
open $testset/$ref/zzz.dock_files/$ref.rec.clean.mol2
open $testset/$system/zzz.dock_files/$system.rec.clean.mol2
open $testset/$system/zzz.dock_files/$system.lig.am1bcc.mol2
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

