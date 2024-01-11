
#!/bin/sh -fe

#
# Edit the lines below to match your desired environment variables. Source this script prior to
# running the others.
#
# Remember to define each variable to meet your cluster/system

### For running the scripts on Cluster

### Source some global variables

	### DOCK home directory
    export DOCKHOMEWORK="/gpfs/projects/rizzo/zzz.programs/dock6.9_mpiv2018.0.3"

	### AMBER home directory
    export AMBERHOMEWORK="/gpfs/software/amber/16/gcc"

	### MOE home directory
	export MOEHOMEWORK="/gpfs/projects/rizzo/zzz.programs/moe_2016.0801/"

    ## DMS home directory
    export DMSHOMEWORK="/gpfs/projects/rizzo/zzz.programs/dms"

	### Root directory (the directory where all run.xxx.csh scripts are located)
	export VS_ROOTDIR="/gpfs/projects/rizzo/ccorbo/Testing_Grounds/Benchmarking_and_Validation/2023_07_CrossDock/zzz.builds"

    ### MPI directory (this is where mpirun is located, compatible with dock6.mpi)
    export VS_MPIDIR="/gpfs/software/intel/parallel-studio-xe/2018_3/compilers_and_libraries/linux/mpi/intel64"


	### Vendor name - library file directory name
	export VS_VENDOR="chris" #example - cdiv, chbr nt1105 sp100309
	
	### Fragment Library (only needed for DN and GA)
	export FRAGLIB="/gpfs/projects/rizzo/ccorbo/Lpxc_systems2/dn_build/fragdir"

	### Anchor Library (only needed for DN)
	export ANCLIB="/gpfs/projects/rizzo/ccorbo/Lpxc_systems2/dn_build/ancdir2"

    ### Max number of molecules to pass to Moe
    export MAX_NUM_MOL="20000" #standard is 100K 

    echo " Running the VS protocol on the SeaWulf Cluster"


