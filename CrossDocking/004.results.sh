module unload anaconda/2
module load anaconda/3
LIST_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists"
CROSSDOCK_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock"
SCRIPT_DIR="/gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock_scripts"
cd ${CROSSDOCK_DIR}

list_of_fam="${LIST_DIR}/set_${1}_family.txt"
for ref_fam in `cat ${list_of_fam}`; do  ### Open for loop 1
cd ${ref_fam}
rm *outcome.txt

list_of_sys1="${LIST_DIR}/${ref_fam}.txt"
for ref_system in `cat ${list_of_sys1}`; do
cd ${ref_system}

list_of_sys2="${LIST_DIR}/${ref_fam}.txt"
for comp_system in `cat ${list_of_sys2}`; do
cd ${comp_system}

python ${SCRIPT_DIR}/RMSDh_extract.py ${comp_system}_${ref_system}.min_scored.mol2 ${comp_system}_${ref_system}.FLX_scored.mol2 > ${comp_system}_${ref_system}.outcome.txt

echo  "$(<${comp_system}_${ref_system}.outcome.txt )"  >> ../../${ref_system}.outcome.txt

cd .. #back to outer system
done
cd .. # Back to family
done
cd .. #Back to base directory
done
