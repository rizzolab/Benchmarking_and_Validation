#!/bin/tcsh
cd ${BUILD_DIR}
set ref_fam ="${LIST_DIR}/family_more_than7.txt"
foreach fam (`cat $ref_fam`)
set list = "${LIST_DIR}/${fam}.txt"
foreach system (`cat $list`)
source run.000.set_env_vars.csh ${system}
tcsh run.001.lig_clean_am1bcc.csh
tcsh run.002.rec_runleap.csh
tcsh run.003.rec_dms_sph.csh
tcsh run.004.rec_grid_cluster.csh
end
end
