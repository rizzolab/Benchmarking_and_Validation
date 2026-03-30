# This script takes the ordering determined in the previous step and reorganizes the actual data in the same order

module unload anaconda/2
module load anaconda/3

RELIST_DIR=$WORK_DIR/zzz.rearrange_lists

echo "Sorting results for family: "
cd ${CROSSDOCK_DIR}

list_of_fam="${LIST_DIR}/zzz.Families.txt"
for ref_fam in `cat ${list_of_fam}`; do
echo ${ref_fam}
cd ${ref_fam}
rm *outcomeh.txt

list_of_sys1="${RELIST_DIR}/${ref_fam}_Rearrangeh.txt"
for ref_system in `cat ${list_of_sys1}`; do
cd ${ref_system}

list_of_sys2="${RELIST_DIR}/${ref_fam}_Rearrangeh.txt"
for comp_system in `cat ${list_of_sys2}`; do
cd ${comp_system}

echo  "$(<${comp_system}_${ref_system}.outcomeh.txt )"  >> ../../${ref_system}.outcomeh.txt

cd .. #back to outer system
done
cd .. # Back to family
done
cd .. #Back to base directory
done
