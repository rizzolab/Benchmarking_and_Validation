
# This script calls RMSDh_extract.py which gets the RMSD for cartesian minimization and all output poses for each crossdocking pair

module load anaconda/3

cd ${CROSSDOCK_DIR}

echo "Getting results for family: "

list_of_fam="${LIST_DIR}/zzz.Families.txt"
for ref_fam in `cat ${list_of_fam}`; do  ### Open for loop 1
echo ${ref_fam} 
cd ${ref_fam}
rm *outcomeh.txt

list_of_sys1="${LIST_DIR}/${ref_fam}.txt"
for ref_system in `cat ${list_of_sys1}`; do
cd ${ref_system}

list_of_sys2="${LIST_DIR}/${ref_fam}.txt"
for comp_system in `cat ${list_of_sys2}`; do
cd ${comp_system}

python ${SCRIPTS_DIR}/RMSDh_extract.py ${comp_system}_${ref_system}.min_scored.mol2 ${comp_system}_${ref_system}.FLX_ranked.mol2  > ${comp_system}_${ref_system}.outcomeh.txt

echo  "$(<${comp_system}_${ref_system}.outcomeh.txt )"  >> ../../${ref_system}.outcomeh.txt


cd .. #back to outer system
done
cd .. # Back to family
done
cd .. #Back to base directory
done
