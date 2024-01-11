#!/bin/sh

# This script writes all of the dock input files for cartesian minimization and docking for every single pair in a family

cd ${CROSSDOCK_DIR}
list_of_fam="${WORK_DIR}/zzz.family_lists/zzz.Families.txt"
for ref_fam in `cat ${list_of_fam}`; do  ### Open for loop 1

echo $ref_fam
mkdir ${ref_fam}
cd ${ref_fam}

list_of_sys1="${WORK_DIR}/zzz.family_lists/${ref_fam}.txt"
for ref_system in `cat ${list_of_sys1}`; do
mkdir ${ref_system}
cd ${ref_system}

list_of_sys2="${WORK_DIR}/zzz.family_lists/${ref_fam}.txt"
for comp_system in `cat ${list_of_sys2}`; do
mkdir ${comp_system}
cd ${comp_system}

### Comp system will be the ligand and the rest of the files will be the ref system
#Writing the minimization script which will minimize each ligand in each receptor
cat >min.in<<EOF
conformer_search_type                                        rigid
use_internal_energy                                          yes
internal_energy_rep_exp                                      12
internal_energy_cutoff                                       100.0
ligand_atom_file                                             ${CROSSDOCK_DIR}/${ref_fam}/${comp_system}/${comp_system}.lig.am1bcc.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               yes
use_rmsd_reference_mol                                       ${CROSSDOCK_DIR}/${ref_fam}/${comp_system}/${comp_system}.lig.am1bcc.mol2 
use_database_filter                                          no
orient_ligand                                                no
bump_filter                                                  no
score_molecules                                              yes
contact_score_primary                                        no
contact_score_secondary                                      no
grid_score_primary                                           yes
grid_score_secondary                                         no
grid_score_rep_rad_scale                                     1
grid_score_vdw_scale                                         1
grid_score_es_scale                                          1
grid_score_grid_prefix                                       ${CROSSDOCK_DIR}/${ref_fam}/${ref_system}/${ref_system}.rec
multigrid_score_secondary                                    no
dock3.5_score_secondary                                      no
continuous_score_secondary                                   no
footprint_similarity_score_secondary                         no
pharmacophore_score_secondary                                no
descriptor_score_secondary                                   no
gbsa_zou_score_secondary                                     no
gbsa_hawkins_score_secondary                                 no
SASA_score_secondary                                         no
amber_score_secondary                                        no
minimize_ligand                                              yes
simplex_max_iterations                                       1000
simplex_tors_premin_iterations                               0
simplex_max_cycles                                           1
simplex_score_converge                                       0.1
simplex_cycle_converge                                       1.0
simplex_trans_step                                           1.0
simplex_rot_step                                             0.1
simplex_tors_step                                            10.0
simplex_random_seed                                          0
simplex_restraint_min                                        yes
simplex_coefficient_restraint                                10.0
atom_model                                                   all
vdw_defn_file                                                /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/vdw_AMBER_parm99.defn
flex_defn_file                                               /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/flex.defn
flex_drive_file                                              /gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.10_mpi/parameters/flex_drive.tbl
ligand_outfile_prefix                                        ${comp_system}_${ref_system}.min
write_orientations                                           no
num_scored_conformers                                        1
rank_ligands                                                 no 
EOF


#Writing the input script for flexible docking
cat >flx.in<<EOF
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
ligand_atom_file                                             ${CROSSDOCK_DIR}/${ref_fam}/${comp_system}/${comp_system}.lig.am1bcc.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               yes
use_rmsd_reference_mol                                       yes
rmsd_reference_filename                                      ${CROSSDOCK_DIR}/${ref_fam}/${comp_system}/${comp_system}.lig.am1bcc.mol2
use_database_filter                                          no
orient_ligand                                                yes
automated_matching                                           yes
receptor_site_file                                           ${CROSSDOCK_DIR}/${ref_fam}/${ref_system}/${ref_system}.rec.clust.close.sph
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
grid_score_grid_prefix                                       ${CROSSDOCK_DIR}/${ref_fam}/${ref_system}/${ref_system}.rec
minimize_ligand                                              yes
minimize_anchor                                              yes
minimize_flexible_growth                                     yes
use_advanced_simplex_parameters                              no
minimize_flexible_growth_ramp                                yes
simplex_initial_score_coverge                                5
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
ligand_outfile_prefix                                        ${comp_system}_${ref_system}.FLX
write_orientations                                           no
num_scored_conformers                                        1000
write_conformations                                          no
rank_ligands                                                 no
EOF



cd ../
done
cd ../
done
cd ../
done
