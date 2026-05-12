# Path to prepared testset files
export testset="YOURPATH/zzz.SB2025_AutoDock_Distribution"

export work_dir_ad4_pr=`pwd`

#list of systems for docking
export system_file_pr="SB2025.systems.all"

#Set a random seed
export seed_ad4_pr=3

#Experiment Name 
#If running Pose Reproduction under multiple conditions give differing names for each experiment here
# to keep track of separate experiments
export conditions_ad4_pr="Default_${seed_ad4_pr}_${seed_ad4_pr}"

#Set path to dock6 compilation
export dock6_dir="YOURPATH"
