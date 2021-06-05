#!/bin/tcsh
#SBATCH --partition=rn-long-40core
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=CD_Trans
#SBATCH --output=CrossDock_Trans

# This script builds all of the aligned systems and if a system fails to build its PDB code gets printed to Incomplete_Builds.txt
tcsh
source 000.source.env.csh

cd ${CROSSDOCK_DIR}
set family_list="${LIST_DIR}/family_more_than7.txt"
foreach ref_fam (`cat $family_list`)
mkdir ${ref_fam}

 
set list_of_sys1="${LIST_DIR}/${ref_fam}.txt"
foreach ref_system (`cat $list_of_sys1`) 
mkdir ./${ref_fam}/${ref_system}

if ( { grep -q '1' ${BUILD_DIR}/${ref_system}/004.grid/${ref_system}.rec.clean.mol2 } ) then
cp ${BUILD_DIR}/${ref_system}/001.lig-prep/${ref_system}.lig.am1bcc.mol2 ${ref_fam}/${ref_system}
cp ${BUILD_DIR}/${ref_system}/004.grid/${ref_system}.rec* ${ref_fam}/${ref_system}

else
echo ${ref_system} >> Inconmplete_Builds.txt

endif

end
end
