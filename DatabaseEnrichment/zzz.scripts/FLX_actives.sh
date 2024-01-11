#!/usr/bin/sh

system=${1}
system_dir=${2}
dock_dir=$3
mpi_dir=$4
processes=$5

mkdir ${system}
cd ${system}


cat >FLX_actives_submit.in<<EOF
conformer_search_type                                        flex
write_fragment_libraries                                     no
user_specified_anchor                                        no
limit_max_anchors                                            no
min_anchor_size                                              5
pruning_use_clustering                                       yes
pruning_max_orients                                          1000
pruning_clustering_cutoff                                    100
pruning_conformer_score_cutoff                               100.0
pruning_conformer_score_scaling_factor                       1.0
use_clash_overlap                                            no
write_growth_tree                                            no
use_internal_energy                                          yes
internal_energy_rep_exp                                      12
internal_energy_cutoff                                       100.0
ligand_atom_file                                             ${system_dir}/${system}/${subset}_final.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               no
use_database_filter                                          no
orient_ligand                                                yes
automated_matching                                           yes
receptor_site_file                                           /${system_dir}/${system}/${system}.rec.clust.close.sph
max_orientations                                             1000
critical_points                                              no
chemical_matching                                            no
use_ligand_spheres                                           no
bump_filter                                                  no
score_molecules                                              yes
contact_score_primary                                        no
grid_score_primary                                           yes
grid_score_rep_rad_scale                                     1
grid_score_vdw_scale                                         1
grid_score_es_scale                                          1
grid_score_grid_prefix                                       /${system_dir}/${system}/${system}.rec
minimize_ligand                                              yes
minimize_anchor                                              yes
minimize_flexible_growth                                     yes
use_advanced_simplex_parameters                              no
minimize_flexible_growth_ramp                                yes
simplex_max_cycles                                           1
simplex_score_converge                                       0.1
simplex_cycle_converge                                       1.0
simplex_trans_step                                           1.0
simplex_rot_step                                             0.1
simplex_tors_step                                            10.0
simplex_anchor_max_iterations                                500
simplex_grow_max_iterations                                  250
simplex_grow_tors_premin_iterations                          0
simplex_random_seed                                          0
simplex_restraint_min                                        no
atom_model                                                   all
vdw_defn_file                                                /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/vdw_AMBER_parm99.defn 
flex_defn_file                                               /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/flex.defn
flex_drive_file                                              /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/flex_drive.tbl
ligand_outfile_prefix                                        ${system}_actives.FLX
write_orientations                                           no
write_conformations                                          no
num_scored_conformers                                        1
rank_ligands                                                 no
EOF

if [ $mpi_dir == "No" ];then
  ${dock_dir}/bin/dock6 -i FLX_actives_submit.in -o FLX_actives_submit.out
else
  ${mpi_dir}/bin/mpirun -np ${processes} ${dock_dir}/bin/dock6.mpi -i FLX_actives_submit.in -o FLX_actives_submit.out
fi

grep "Grid_Score:" ${system}_actives.FLX_scored.mol2 | awk '{print $3}' | while read line; do
echo -n ${line} >> Active_score.txt
echo " Active" >> Active_score.txt
done

cd ../



