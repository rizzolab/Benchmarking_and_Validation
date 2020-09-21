
#!/bin/tcsh -fe

#
# Edit the lines below to match your desired environment variables. Source this script prior to
# running the others.
#
# Remember to define each variable to meet your cluster/system

### For running the scripts on Cluster

### Source some global variables

	### DOCK home directory
    setenv DOCKHOMEWORK /gpfs/projects/rizzo/zzz.programs/dock6.9_mpiv2018.0.3

	### AMBER home directory
    setenv AMBERHOMEWORK /gpfs/software/amber/16/gcc

	### MOE home directory
	setenv MOEHOMEWORK /gpfs/projects/rizzo/zzz.programs/moe_2016.0801/

    ## DMS home directory
    setenv DMSHOMEWORK /gpfs/projects/rizzo/zzz.programs/dms

	### Root directory (the directory where all run.xxx.csh scripts are located)
	setenv VS_ROOTDIR  /gpfs/projects/rizzo/ccorbo/DOCK6_with_ambpdb

    ### MPI directory (this is where mpirun is located, compatible with dock6.mpi)
    setenv VS_MPIDIR /gpfs/software/intel/parallel-studio-xe/2018_3/compilers_and_libraries/linux/mpi/intel64

	### System name
	setenv VS_SYSTEM $1 #example - gp41.outerpocket located in zzz.master

	### Vendor name - library file directory name
	setenv VS_VENDOR chris #example - cdiv, chbr nt1105 sp100309
	
	### Fragment Library (only needed for DN and GA)
	setenv FRAGLIB /gpfs/projects/rizzo/ccorbo/Lpxc_systems2/dn_build/fragdir

	### Anchor Library (only needed for DN)
	setenv ANCLIB /gpfs/projects/rizzo/ccorbo/Lpxc_systems2/dn_build/ancdir2

    ### Max number of molecules to pass to Moe
    setenv MAX_NUM_MOL 20000 #standard is 100K 

    echo " Running the VS protocol on the SeaWulf Cluster"


