#!/bin/sh -fe

#
# This script prepares the ligand that will be used as a footprint reference. Input required is:
# ${system}.lig.moe.mol2, which is the ligand prepared in MOE by adding hydrogens and computing
# gasteiger charges.
#
# Note that the environment variable $AMBERHOME should be externally to this script.
#

id| awk '{print $1}'| awk -F'(' '{print $2}'

### Set some paths
dockdir="${DOCKHOMEWORK}/bin"
amberdir="${AMBERHOMEWORK}/bin"
moedir="${MOEHOMEWORK}/bin"
rootdir="${VS_ROOTDIR}"
masterdir="${rootdir}/zzz.master"
paramdir="${rootdir}/zzz.parameters"
scriptdir="${rootdir}/zzz.scripts"
zincdir="${rootdir}/zzz.zinclibs"
system=${1}
vendor="${VS_VENDOR}"


### Check to see if the ligfile exists
if ! ls -l ${masterdir} | grep -q "${system}.lig.moe.mol2";  then
	echo "Ligand file does not seem to exist. Exiting.";
	exit
fi


cd ${rootdir}/${system}/001.lig-prep/


##################################################
cat>dock.lig.in<<EOF
conformer_search_type                                        rigid
use_internal_energy                                          no
ligand_atom_file                                             temp2.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               no
use_database_filter                                          no
orient_ligand                                                no
bump_filter                                                  no
score_molecules                                              no
ligand_outfile_prefix                                        lig
write_orientations                                           no
num_scored_conformers                                        1
rank_ligands                                                 no
EOF
##################################################

### Pre-process the ligand with DOCK
echo -n "$system LIG : "
perl -pe 's/\r\n/\n/g' ${masterdir}/${system}.lig.moe.mol2 > temp1.mol2
perl ${scriptdir}/lig_unique_name.pl temp1.mol2 ${system} yes > temp2.mol2
${dockdir}/dock6 -i dock.lig.in -o dock.lig.out
mv lig_scored.mol2 ${system}.lig.processed.mol2



rm -f temp1.mol2 temp2.mol2 lig_scored.mol2 dock.lig.in

${amberdir}/antechamber -fi mol2 -fo mol2 -c gas -j 5 -at sybyl -s 2 -pf y -i ${system}.lig.processed.mol2 -o ${system}.lig.gast.mol2 -dr n 

