#This script sorts outcome per system by best to worst rank
sort -n -k2 zzy.cognate_rec_rank.dat > zzy.cognate_rec_rank_sort.dat
sort -n -k2 zzy.cognate_rec_rank_w_pairs.dat > zzy.cognate_rec_rank_w_pairs_sort.dat 
sort -n -k2 zzy.cognate_rec_rank_w_class_pairs.dat > zzy.cognate_rec_rank_w_class_pairs_sort.dat 
