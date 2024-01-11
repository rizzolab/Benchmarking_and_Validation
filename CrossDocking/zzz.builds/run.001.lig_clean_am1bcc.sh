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


### Make the lig-prep directory
rm -fr ${rootdir}/${system}/001.lig-prep/
mkdir -p ${rootdir}/${system}/001.lig-prep/
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


### If it exists, also pre-process the cofactor with DOCK
if ls -l ${masterdir} | grep -q  "${system}.cof.moe.mol2"; then
	echo -n "$system COF : "
	perl -pe 's/\r\n/\n/g' ${masterdir}/${system}.cof.moe.mol2 > temp1.mol2
	perl ${scriptdir}/lig_unique_name.pl temp1.mol2 ${system} yes > temp2.mol2
	${dockdir}/dock6 -i dock.lig.in -o dock.cof.out
	sed -e s/LIG/COF/ -e s/lig/cof/ lig_scored.mol2 > ${system}.cof.processed.mol2
fi

rm -f temp1.mol2 temp2.mol2 lig_scored.mol2 dock.lig.in

### Compute ligand charges with antechamber
${amberdir}/acdoctor -i ${system}.lig.processed.mol2 -f mol2 >& ac.lig.log

#if ( `grep "Fatal Error" ac.lig.log | wc -l` ) then
#   cat ac.lig.log
#   echo "Fatal Error occurred in ligand preparation. Check ./${system}/001.lig-prep/ac.lig.log for more information."
#   exit
#fi

${amberdir}/antechamber -fi mol2 -fo mol2 -c bcc -j 5 -at sybyl -s 2 -pf y -i ${system}.lig.processed.mol2 -o ${system}.lig.am1bcc.mol2 -dr n 
if grep -q "No convergence in SCF" sqm.out ; then
	${amberdir}/antechamber -fi mol2 -fo mol2 -c bcc -j 5 -at sybyl -s 2 -pf y -ek "itrmax=100000, qm_theory='AM1', grms_tol=0.0002, tight_p_conv=0, scfconv=1.d-8" -i $system.lig.processed.mol2 -o $system.lig.am1bcc.mol2
fi
mv sqm.out sqm.lig.out
mv sqm.in sqm.lig.in


### If it exists, also compute cofactor charges
if  ls ${masterdir} | grep -q "${system}.cof.moe.mol2" ; then
	${amberdir}/acdoctor -i ${system}.cof.processed.mol2 -f mol2
	${amberdir}/antechamber -fi mol2 -fo mol2 -c bcc -j 1 -at sybyl -s 2 -pf y -i ${system}.cof.processed.mol2 -o ${system}.cof.am1bcc.mol2
	if grep -q "No convergence in SCF" sqm.out ; then
		${amberdir}/antechamber -fi mol2 -fo mol2 -c bcc -j 5 -at sybyl -s 2 -pf y -ek "itrmax=100000, qm_theory='AM1', grms_tol=0.0002, tight_p_conv=0, scfconv=1.d-8" -i $system.cof.processed.mol2 -o $system.cof.am1bcc.mol2
	fi
	mv sqm.out sqm.cof.out
	mv sqm.in sqm.cof.in
fi

exit


