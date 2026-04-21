# Path to prepared testset files
export testset="YOURPATH/zzz.SB2025_AutoDock_Distribution"

#list of systems for docking
export system_file="clean.systems.all"

#Set a random seed
export seed=3

#Experiment Name 
#If running Pose Reproduction under multiple conditions give differing names for each experiment here
# to keep track of separate experiments
export conditions="Default_${seed}_${seed}"
