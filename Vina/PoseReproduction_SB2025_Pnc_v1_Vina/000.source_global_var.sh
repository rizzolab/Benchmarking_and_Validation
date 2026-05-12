# Path to prepared testset files
export testset="YOURPATH/zzz.SB2025_AutoDock_Distribution"

#list of systems for docking
export system_file_pr="SB2025.systems.all"

#Set a random seed
export seed_vina_pr=1

#Experiment Name 
#If running Pose Reproduction under multiple conditions give differing names for each experiment here
# to keep track of separate experiments
export conditions_vina_pr="Default_${seed_vina_pr}"

#Set path to dock6 compilation
export dock6_dir="YOURPATH"
