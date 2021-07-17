# This script calls Rearrange_Lists.py which will sort the results to make the output heatmaps organized

module unload anaconda/2
module load anaconda/3

WORK_DIR="/gpfs/projects/rizzo/ccorbo/Testing_Grounds/Benchmarking_and_Validation/CrossDocking"
CROSSDOCK_DIR="${WORK_DIR}/zzz.crossdock"
LIST_DIR="${WORK_DIR}/zzz.sample_lists"
SCRIPT_DIR="${WORK_DIR}/zzz.crossdock_scripts"
RELIST_DIR="${WORK_DIR}/zzz.rearrange_lists"

echo "Sorting results for family: "

list_of_fam="${LIST_DIR}/family_more_than7.txt"
for ref_fam in `cat ${list_of_fam}`; do
echo ${ref_fam}
cd ${CROSSDOCK_DIR}/${ref_fam}
python ${SCRIPT_DIR}/Rearrange_Lists.py ${LIST_DIR}/${ref_fam}.txt >> ${RELIST_DIR}/${ref_fam}_Rearrange.txt

done
