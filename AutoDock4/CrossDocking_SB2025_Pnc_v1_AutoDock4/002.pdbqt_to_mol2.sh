#!/bin/sh
#SBATCH --partition=
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=002_AD4_convert_type
#SBATCH --output=002_AD4_convert_type.out

#This script converts pdbqt to mol2 and also determines lowest energy conformation 
module load openbabel/2.4.1 
List_dir="$work_dir/zzz.family_lists"

cd $crossdock_dir

for ref_fam in `  cat $List_dir/zzz.Families.txt`;do
  echo ${ref_fam}
  cd ${ref_fam}
  for ref_sys in `cat $List_dir/${ref_fam}.txt`;do
    cd $ref_sys
    for comp_sys in `cat $List_dir/${ref_fam}.txt`;do
      cd $comp_sys
      #remove hydrogen from reference
      obabel ../../${ref_sys}.lig.gast.pdbqt -O ${ref_sys}.lig.gast.noH.mol2 -d
      #create pdbqt of docked poses
      grep '^DOCKED' ${comp_sys}.docking.dlg | cut -c9- > ${comp_sys}.docking.pdbqt
      #remove hydrogens from docked poses pdbqt
      obabel ${comp_sys}.docking.pdbqt -O ${comp_sys}.docking.noH.mol2 -d
      grep -A8 "LOWEST ENERGY DOCKED CONFORMATION" ${comp_sys}.docking.dlg  | tail -n1 | awk '{print $4}' > index_lowest_score.txt
      cd ..
    done
    cd ..
  done 
  cd ..
done
