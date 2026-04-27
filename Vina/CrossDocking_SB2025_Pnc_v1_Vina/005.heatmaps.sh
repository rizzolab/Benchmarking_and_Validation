
module load anaconda/3

List_dir="$work_dir/zzz.family_lists"

mkdir ${work_dir}/HeatMaps

echo "Making heatmap for family: "

list_of_fam="${List_dir}/zzz.Families.txt"
for ref_fam in `cat ${list_of_fam}`; do
echo $ref_fam
cd ${crossdock_dir}/${ref_fam}

python ${work_dir}/Make_ploth.py $dock6_rearrange_dir/${ref_fam}_Rearrangeh.txt $ref_fam >> ${work_dir}/Statistics_h.txt
mv heatmap.pdf ${work_dir}/HeatMaps/${ref_fam}.W_PDB.RMSDh.heatmap.pdf


done
