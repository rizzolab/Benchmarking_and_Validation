#This script is used for modifying the format of the mol2 to satisfy mgl tools for AutoDock

system_file="CrossDocking_sys.txt"
for system in `cat ${system_file}`; do  
echo ${system}
cd /gpfs/projects/rizzo/ccorbo/Testing_Grounds/Benchmarking_and_Validation/CrossDocking/zzz.builds/${system} 
mkdir zzz.autodockfiles
cd zzz.autodockfiles
python ../../modify_mol2_autodock.py ../002.rec-prep/${system}.rec.clean.mol2 >> ${system}.rec.clean.mol2
done
