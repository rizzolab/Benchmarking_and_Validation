
#!/bin/tcsh -fe

#
# Edit the lines below to match your desired environment variables. Source this script prior to
# running the others.
#
# Remember to define each variable to meet your cluster/system

### For running the scripts on Cluster
if (`hostname -f` == "login1.cm.cluster" || `hostname -f` == "login2.cm.cluster" || `hostname -f ` == "rizzo.cm.cluster") then

### Source some global variables

setenv LIST_DIR /gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists

setenv WORK_DIR /gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking

setenv BUILD_DIR /gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.builds

setenv CROSSDOCK_DIR /gpfs/projects/rizzo/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock
    echo " Running the VS protocol on the SeaWulf Cluster"
    exit

endif




else 
	echo "There was a problem assigning env variables needed for the VS protocol; you may have to do it manually."
        echo "This error is a result of the hostname not being recognized"
        echo " Type the commmand  'hostname -f ' and add that result to this script"
endif

