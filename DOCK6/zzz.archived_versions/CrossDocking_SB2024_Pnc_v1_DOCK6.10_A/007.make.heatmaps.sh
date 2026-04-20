#!/bin/sh
#SBATCH --partition=rn-long-40core
#SBATCH --time=150:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=hm
#SBATCH --output=hm
#This script calls Make_plot.py which will print the statistics for all families to Statistics.txt and make a heatmap for each family in the HeatMaps directory

module unload anaconda/2
module load anaconda/3

RELIST_DIR=$WORK_DIR/zzz.rearrange_lists

mkdir ${WORK_DIR}/HeatMaps

echo "Making heatmap for family: "

list_of_fam="${LIST_DIR}/zzz.Families.txt"
for ref_fam in `cat ${list_of_fam}`; do
echo ${ref_fam}
echo ${ref_fam} >> ${WORK_DIR}/Statistics.txt
cd ${CROSSDOCK_DIR}/${ref_fam}

python ${SCRIPTS_DIR}/Make_ploth.py ${RELIST_DIR}/${ref_fam}_Rearrangeh.txt  $ref_fam >> ${WORK_DIR}/Statistics_h.txt

mv heatmap.png ${WORK_DIR}/HeatMaps/${ref_fam}.No_PDB.RMSDh.heatmap.png

#python ${SCRIPT_DIR}/Make_plotm.py ${RELIST_DIR}/${ref_fam}_Rearrangem.txt >> ${WORK_DIR}/Statistics_m.txt

#mv heatmap.png ${WORK_DIR}/HeatMaps/${ref_fam}.RMSDm.heatmap.png

done
