#!/bin/sh -fe

#
# This script will run the grid program. Parameters to set include the attractive and repulsive vdw
# exponents. We usually do 6-9, respectively, to 'soften' the receptor landscape. Grid spacing is
# typically set to 0.4. The box margin, or the distance beyond the spheres in every direction is 
# typically set to 8 angstroms. Finally, make sure sphcut and maxkeep match the previous csh script.
#

id| awk '{print $1}'| awk -F'(' '{print $2}'


### Set some variables manually
attractive="6"
repulsive="9"
grid_spacing="0.3"
box_margin="8"
sphcut="8"
maxkeep="75"


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

### Make sure the receptor and spheres are present
if  ! ls -l  ${rootdir}/${system}/002.rec-prep | grep -q "${system}.rec.clean.mol2" ;then
	echo "Missing ${system}.rec.clean.mol2. Exiting."
	exit
fi

if  ! ls -l ${rootdir}/${system}/003.spheres | grep -q "${system}.rec.clust.close.pdb" ;then
	echo "Missing ${system}.rec.clust.close.pdb. Exiting."
	exit
fi


### Make the grid preparation directory
rm -fr ${rootdir}/${system}/004.grid/
mkdir -p ${rootdir}/${system}/004.grid/
cd ${rootdir}/${system}/004.grid/


### Link and copy some files here
ln -s ../002.rec-prep/${system}.rec.clean.mol2 ./
ln -s ../003.spheres/${system}.rec.clust.close.sph ./
cp ${paramdir}/vdw_AMBER_parm99.defn ./vdw.defn
cp ${paramdir}/chem.defn ./chem.defn


### Construct box.pdb centered on spheres 
##################################################
cat  >box.in <<EOF
yes
$box_margin
./${system}.rec.clust.close.sph
1
box.pdb
EOF
##################################################
${dockdir}/showbox < box.in


### Construct grid using receptor mol2 file
##################################################
cat  >grid.in<<EOF
compute_grids                  yes
grid_spacing                   ${grid_spacing}
output_molecule                no
contact_score                  no
chemical_score		       no
energy_score                   yes
energy_cutoff_distance         999
atom_model                     a
attractive_exponent            ${attractive}
repulsive_exponent             ${repulsive}
distance_dielectric            yes
dielectric_factor              4
bump_filter                    yes
bump_overlap                   0.75
receptor_file                  ./${system}.rec.clean.mol2
box_file                       ./box.pdb
vdw_definition_file            ./vdw.defn
chemical_definition_file       ./chem.defn
score_grid_prefix              ./${system}.rec
EOF
##################################################
${dockdir}/grid -v -i grid.in -o grid.out


exit


