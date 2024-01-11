# This script calls Rearrange_Lists.py which will sort the results to make the output heatmaps organized

module unload anaconda/2
module load anaconda/3


mkdir zzz.rearrange_lists
RELIST_DIR=$WORK_DIR/zzz.rearrange_lists

echo "Sorting results for family: "
cd ${CROSSDOCK_DIR}

list_of_fam="${LIST_DIR}/zzz.Families.txt"
for ref_fam in `cat ${list_of_fam}`; do
echo ${ref_fam}
cd ${ref_fam}
python ${SCRIPTS_DIR}/Rearrange_Listsh.py ${LIST_DIR}/${ref_fam}.txt > ${RELIST_DIR}/${ref_fam}_Rearrangeh.txt
cd ..
done
