# Path to prepared testset files
export testset="YOURPATH/SB2025_v1_AutoDock_CDfam"

#Set a random seed
export seed=3

export work_dir=`pwd`

#This is where crossdocking will be run
export crossdock_dir="${work_dir}/zzz.crossdock"

#Set path to dock6 compilation
export dock6_dir="YOURPATH"

#DOCK6 Crossdocking must be run prior to this experiment, for ordering of heatmaps and determination of incompatible pairing
export dock6_crossdock_dir="YOURPATH/Benchmarking_and_Validation/DOCK6/CrossDocking_SB2025_Pnc_v1_DOCK6.12_A"

export dock6_rearrange_dir="$dock6_crossdock_dir/zzz.rearrange_lists"
