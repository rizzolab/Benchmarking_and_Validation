module unload anaconda/2
module load anaconda/3

LIST_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists"
CROSSDOCK_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock"
SCRIPT_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock_scripts"
RELIST_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.rearrange_lists"

mkdir HeatMaps

echo "Making heatmap for family: "

list_of_fam="${LIST_DIR}/family_more_than7.txt"
for ref_fam in `cat ${list_of_fam}`; do
echo ${ref_fam}
cd ${CROSSDOCK_DIR}/${ref_fam}

python ${SCRIPT_DIR}/Make_plot.py ${RELIST_DIR}/${ref_fam}_Rearrange.txt

mv heatmap.png ${CROSSDOCK_DIR}/HeatMaps/${ref_fam}.heatmap.png
done
