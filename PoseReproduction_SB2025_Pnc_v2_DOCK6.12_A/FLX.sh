#!/usr/bin/sh

# This script requires a list of system names, and will create a subdirectory for each system in the directory where this script is run

system=${1}
system_dir=${2}
seed=$3
function=$4
dock_dir=$5
mkdir ${system}
cd ${system}


cat >FLX_${seed}.in<<EOF
conformer_search_type                                        flex
write_fragment_libraries                                     no
user_specified_anchor                                        no
limit_max_anchors                                            no
min_anchor_size                                              5
pruning_use_clustering                                       yes
pruning_max_orients                                          1000
pruning_clustering_cutoff                                    100
pruning_conformer_score_cutoff                               100.0
pruning_orient_score_cutoff                                  1000
pruning_conformer_score_scaling_factor                       1.0
use_clash_overlap                                            no
write_growth_tree                                            no
use_internal_energy                                          yes
internal_energy_rep_exp                                      12
internal_energy_cutoff                                       100.0
ligand_atom_file                                             /${system_dir}/${system}/${system}.lig.am1bcc.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               yes
use_rmsd_reference_mol                                       yes
rmsd_reference_filename                                      /${system_dir}/${system}/${system}.lig.am1bcc.mol2
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
grid_lig_efficiency                                          no
grid_score_grid_prefix                                       /${system_dir}/${system}/${system}.rec
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
simplex_final_min                                            no
simplex_random_seed                                          $seed
simplex_restraint_min                                        no
atom_model                                                   all
vdw_defn_file                                                $dock_dir/parameters/vdw_AMBER_parm99.defn 
flex_defn_file                                               $dock_dir/parameters/flex.defn
flex_drive_file                                              $dock_dir/parameters/flex_drive.tbl
ligand_outfile_prefix                                        ${function}_$seed
write_mol_solvation					     no
write_orientations                                           no
write_conformations					     yes 
num_scored_conformers                                        1000 
cluster_conformations                                        yes
cluster_rmsd_threshold   				     2
score_threshold                                              100
rank_ligands                                                 no
EOF

${dock_dir}/bin/dock6 -i FLX_${seed}.in -o FLX_${seed}.out

cd ../
