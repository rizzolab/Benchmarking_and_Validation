#This script calls Make_plot.py which will print the statistics for all families to Statistics.txt and make a heatmap for each family in the HeatMaps directory

module unload anaconda/2
module load anaconda/3

WORK_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking"
CROSSDOCK_DIR="${WORK_DIR}/zzz.crossdock"
LIST_DIR="${WORK_DIR}/zzz.sample_lists"
SCRIPT_DIR="${WORK_DIR}/zzz.crossdock_scripts"
RELIST_DIR="${WORK_DIR}/zzz.rearrange_lists"


mkdir ${WORK_DIR}/HeatMaps

echo "Making heatmap for family: "

list_of_fam="${LIST_DIR}/family_more_than7.txt"
for ref_fam in `cat ${list_of_fam}`; do

echo ${ref_fam}
echo ${ref_fam} >> ${WORK_DIR}/Statistics.txt
cd ${CROSSDOCK_DIR}/${ref_fam}

python ${SCRIPT_DIR}/Make_plot.py ${RELIST_DIR}/${ref_fam}_Rearrange.txt >> ${WORK_DIR}/Statistics.txt

mv heatmap.png ${WORK_DIR}/HeatMaps/${ref_fam}.heatmap.png
done
