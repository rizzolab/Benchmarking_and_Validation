#openbabel used for pdbqt to mol2 conversion. Alternatively chimera could be used
module load openbabel

for sys in `  cat ${system_file_pr}`
  do
  
  echo ${sys}
  cd ${sys}
  
  #Copy original ligand for atom type mapping/ matching
  cp ${testset}/${sys}/${sys}.lig.gast.pdbqt ./
  
  #Delete all Hydrogens. There is a disparity in #H used for DOCK6 mol2 (all atom) and AutoDock pdbqt (united) and this causes issues
  #when calculating RMSDh later on, even though RMSDh doesnt include H, will still throw error if # atom not identical in calc.
  obabel ${sys}.lig.gast.pdbqt -O ${sys}.lig.gast.noH.mol2 -d
  
  #Delete Hydrogens and convert to mol2 
  obabel  ${sys}.vina.$conditions_vina_pr.pdbqt -O ${sys}.${conditions_vina_pr}.docking.noH.mol2 -d
  
  cd ../

done
