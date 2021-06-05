# This script takes the ordering determined in the previous step and reorganizes the actual data in the same order

module unload anaconda/2
module load anaconda/3

WORK_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking"
CROSSDOCK_DIR="${WORK_DIR}/zzz.crossdock"
LIST_DIR="${WORK_DIR}/zzz.sample_lists"
SCRIPT_DIR="${WORK_DIR}/zzz.crossdock_scripts"
RELIST_DIR="${WORK_DIR}/zzz.rearrange_lists"

cd ${CROSSDOCK_DIR}

echo "Sorting results for family: "

list_of_fam="${LIST_DIR}/family_more_than7.txt"
for ref_fam in `cat ${list_of_fam}`; do
echo ${ref_fam}
cd ${ref_fam}
rm *outcome.txt

list_of_sys1="${RELIST_DIR}/${ref_fam}_Rearrange.txt"
for ref_system in `cat ${list_of_sys1}`; do
cd ${ref_system}

list_of_sys2="${RELIST_DIR}/${ref_fam}_Rearrange.txt"
for comp_system in `cat ${list_of_sys2}`; do
cd ${comp_system}

echo  "$(<${comp_system}_${ref_system}.outcome.txt )"  >> ../../${ref_system}.outcome.txt

cd .. #back to outer system
done
cd .. # Back to family
done
cd .. #Back to base directory
done
