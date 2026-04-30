#THIS requires a file which is sorted primarily on ascending score and secondary on alphanumerical active / decoy so all isoenergetic actives come first and then decoys

#You should use a dictionary for pairs of active/decoy score and count
import math
#First create lists so you can determine frequency, and then you use the score frequency pairs to create dicts
actives_scores=[]
decoys_scores=[]
overlap=[]
all_scores=[]
with open('All_score_sort.txt','r') as filereader:
	for line in filereader:
		line_spl=line.split()
		if line_spl[0]=="active":
			if len(line_spl)==2:
				actives_scores.append(line_spl[1])
				if line_spl[1] not in all_scores:
					all_scores.append(line_spl[1])
		else:
			if len(line_spl)==2:
				decoys_scores.append(line_spl[1])
				if line_spl[1] not in all_scores:
					all_scores.append(line_spl[1])
				#Check if this value occurs in actives_scores
				if line_spl[1] in actives_scores:
					if line_spl[1] not in overlap:
						overlap.append(line_spl[1])

act_dict={}
tmp_score=0
freq=1
for score in actives_scores:
	if score == tmp_score:
		freq=freq+1
		act_dict[score]=freq
	else:
		freq=1
		tmp_score=score
		act_dict[score]=freq

dec_dict={}
tmp_score=0
freq=1
for score in decoys_scores:
	if score == tmp_score:
		freq=freq+1
		dec_dict[score]=freq
	else:
		freq=1
		tmp_score=score
		dec_dict[score]=freq


#print(act_dict)

for score in all_scores:
	act_freq=0
	dec_freq=0
	#In both lists
	if score in overlap:
		act_freq=act_dict[score]
		dec_freq=dec_dict[score]

		if dec_freq > act_freq:
			num=math.floor(dec_freq/(act_freq+1))
			for i in range(act_freq):
				print("active " + str(score))
				for j in range(num):
					print("decoy " + str(score))
			for j in range(num):
				print("decoy " + str(score))

			for mod in range(dec_freq%(act_freq+1)):
				print("decoy " + str(score))
		else:
			num=math.floor(act_freq/(dec_freq+1))
			for i in range(act_freq):
				for j in range(num):
					print("active " + str(score))
				print("decoy " + str(score))
			for j in range(num):
				print("active " + str(score))

			for mod in range(act_freq%(dec_freq+1)):
				print("active " + str(score))

	#Not in both list
	else:
		#score only in active
		if score in act_dict:
			act_freq=act_dict[score]
			for i in range(act_freq):
				print("active " + str(score))
		#Score only in decoy
		else:
			dec_freq=dec_dict[score]
			for i in range(dec_freq):
				print("decoy " + str(score))

	#print(str(score) + " " + str(act_freq) + " " + str(dec_freq))
