#!/bin/tcsh
# This script will run the scripts to prepare all of the files necessary for constructing aligned crossdocking systems 
# Namely (ligand and receptor mol2, spheres files and grid files)
module unload anaconda/3
module load anaconda/2

cd ${BUILD_DIR}
set list = "${LIST_DIR}/${1}.txt"
foreach system (`cat $list`)
source run.000.set_env_vars.csh ${system}
tcsh run.001.lig_clean_am1bcc.csh
tcsh run.002.rec_runleap.csh
tcsh run.003.rec_dms_sph.csh
tcsh run.004.rec_grid_cluster.csh
end
end
