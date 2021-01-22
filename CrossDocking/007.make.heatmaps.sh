module unload anaconda/2
module load anaconda/3

LIST_DIR="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists"
CROSSDOCK_DIR="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock"
SCRIPT_DIR="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock_scripts"
RELIST_DIR="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.rearrange_lists"
WORK_DIR="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking"

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
