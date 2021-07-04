#!/bin/tcsh
# This script will run the scripts to prepare all of the files necessary for constructing aligned crossdocking systems 
# Namely (ligand and receptor mol2, spheres files and grid files)

source ../000.source.env.csh
set list = "${LIST_DIR}/${1}.txt"

foreach system (`cat $list`)
tcsh run.001.lig_clean_am1bcc.csh ${system}
tcsh run.002.rec_runleap.csh ${system}
tcsh run.003.rec_dms_sph.csh ${system}
tcsh run.004.rec_grid_cluster.csh ${system}
end
