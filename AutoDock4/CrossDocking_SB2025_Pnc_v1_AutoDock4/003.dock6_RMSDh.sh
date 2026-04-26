#!/bin/sh
#SBATCH --partition=
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=003_AD4_RMSDh
#SBATCH --output=003_AD4_RMSDh.out

#This script calculates RMSDh with DOCK6

cd $crossdock_dir

List_dir="$work_dir/zzz.family_lists"
for ref_fam in `  cat $List_dir/zzz.Families.txt`;do

echo ${ref_fam}
cd ${ref_fam}

for ref_sys in `cat $dock6_rearrange_dir/${ref_fam}_Rearrangeh.txt`;do
cd $ref_sys

for comp_sys in `cat $dock6_rearrange_dir/${ref_fam}_Rearrangeh.txt`;do
cd $comp_sys

rm RMSDh_grep.txt
rm rescore.in

cat >rescore.in<<EOF
conformer_search_type                                        rigid
use_internal_energy                                          yes
internal_energy_rep_exp                                      12
internal_energy_cutoff                                       100.0
ligand_atom_file                                             ${comp_sys}.docking.noH.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               yes
use_rmsd_reference_mol                                       yes
rmsd_reference_filename                                      ${ref_sys}.lig.gast.noH.mol2
use_database_filter                                          no
orient_ligand                                                no
bump_filter                                                  no
score_molecules                                              no
atom_model                                                   united
vdw_defn_file                                                $dock6_dir/parameters/vdw_AMBER_parm99.defn
flex_defn_file                                               $dock6_dir/parameters/flex.defn
flex_drive_file                                              $dock6_dir/parameters/flex_drive.tbl
ligand_outfile_prefix                                        ${comp_sys}.${ref_sys}.dockingRMSD
write_mol_solvation                                          no
write_orientations                                           no
num_scored_conformers                                        10
write_conformations                                          yes
cluster_conformations                                        no
score_threshold                                              99999
rank_ligands                                                 no
EOF

$dock6_dir/bin/dock6 -i rescore.in -o rescore.out

grep "HA_RMSDh:" ${comp_sys}.${ref_sys}.dockingRMSD_scored.mol2 | awk '{print $3}' >> RMSDh_grep.txt

cd ..
done

cd ..
done

cd ..
done
