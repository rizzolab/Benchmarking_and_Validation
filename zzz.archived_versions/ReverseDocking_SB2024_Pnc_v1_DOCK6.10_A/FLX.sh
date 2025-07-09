#!/usr/bin/sh

# This script requires a list of system names, and will create a subdirectory for each system in the directory where this script is run

lig_system=${1}
rec_system=$2
system_dir=${3}
seed=$4
cd ${lig_system}


cat >FLX_${rec_system}_${seed}.in<<EOF
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
ligand_atom_file                                             /${system_dir}/${lig_system}/${lig_system}.lig.am1bcc.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               no
use_database_filter                                          no
orient_ligand                                                yes
automated_matching                                           yes
receptor_site_file                                           /${system_dir}/${rec_system}/${rec_system}.rec.clust.close.sph
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
grid_score_grid_prefix                                       /${system_dir}/${rec_system}/${rec_system}.rec
minimize_ligand                                              yes
minimize_anchor                                              yes
minimize_flexible_growth                                     yes
use_advanced_simplex_parameters                              no
minimize_flexible_growth_ramp                                yes
simplex_max_cycles                                           1
simplex_score_converge                                       0.1
simplex_initial_score_coverge                                5
simplex_cycle_converge                                       1.0
simplex_trans_step                                           1.0
simplex_rot_step                                             0.1
simplex_tors_step                                            10.0
simplex_anchor_max_iterations                                500
simplex_grow_max_iterations                                  250
simplex_grow_tors_premin_iterations                          0
simplex_random_seed                                          $seed
simplex_restraint_min                                        no
atom_model                                                   all
vdw_defn_file                                                /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/vdw_AMBER_parm99.defn 
flex_defn_file                                               /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/flex.defn
flex_drive_file                                              /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/flex_drive.tbl
ligand_outfile_prefix                                        ${lig_system}_${rec_system}_$seed
write_orientations                                           no
num_scored_conformers                                        1000 
write_conformations                                          no
rank_ligands                                                 no
EOF


/gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/bin/dock6 -i FLX_${rec_system}_${seed}.in -o FLX_${rec_system}_${seed}.out

cd ../
