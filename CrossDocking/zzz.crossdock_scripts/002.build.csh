#!/bin/tcsh
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
