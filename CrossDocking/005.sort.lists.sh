LIST_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists"
CROSSDOCK_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock"
SCRIPT_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock_scripts"
RELIST_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.rearrange_lists"

list_of_fam="${LIST_DIR}/set_${1}_family.txt"
for ref_fam in `cat ${list_of_fam}`; do
cd ${CROSSDOCK_DIR}/${ref_fam}
python ${SCRIPT_DIR}/Rearrange_Lists.py ${LIST_DIR}/${ref_fam}.txt >> ${RELIST_DIR}/${ref_fam}_Rearrange.txt

done
