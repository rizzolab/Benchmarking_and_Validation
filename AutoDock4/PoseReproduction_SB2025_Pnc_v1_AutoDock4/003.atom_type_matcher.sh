#openbabel used for pdbqt to mol2 conversion. Alternatively chimera could be used
module load openbabel

for sys in `  cat ${system_file}`
do

echo ${sys}
cd ${sys}

#Copy original ligand for atom type mapping/ matching
cp ${testset}/${sys}/${sys}.lig.gast.pdbqt ./

#Delete all Hydrogens. There is a disparity in #H used for DOCK6 mol2 (all atom) and AutoDock pdbqt (united) and this causes issues
#when calculating RMSDh later on, even though RMSDh doesnt include H, will still throw error if # atom not identical in calc.
obabel ${sys}.lig.gast.pdbqt -O ${sys}.lig.gast.noH.mol2 -d

#Extract pdbqt dock poses from dlg
grep '^DOCKED' ${sys}.${conditions}.docking.dlg | cut -c9- > ${sys}.${conditions}.docking.pdbqt
#Delete Hydrogens 
obabel ${sys}.${conditions}.docking.pdbqt -O ${sys}.${conditions}.docking.noH.mol2 -d

#Make sure this is getting index of lowest scoring conformation
grep -A8 "LOWEST ENERGY DOCKED CONFORMATION" ${sys}.${conditions}.docking.dlg  | tail -n1 | awk '{print $4}' > index_lowest_score_${conditions}.txt

cd ../

done
