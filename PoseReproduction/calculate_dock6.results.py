#!/usr/bin/env python
from sys import argv
import  os
import datetime
###################################################################################################################
################ OUTCOME_GRID ######################
##################################

def outcome_grid(input):
    if (not os.path.isfile(input)):
        return 0
    if (os.path.getsize(input) == 0):
#        print input + " is empty."
#        print 'Did not finish'
        return 0
    file = open(input, 'r')
    lines = file.readlines()
    RMSDarray = []
    for line in lines:
        splitline = line.split()
        if len(splitline) == 3:
           if splitline[1] == "HA_RMSDh:":
              RMSDarray.append(float(splitline[2]))
    if RMSDarray[0] <= 2.0: # DOCK success
#        print 'DockSuccess'
        return 1
    RMSDarray.sort()
    if RMSDarray[0] <= 2.0: 
#        print 'scoringFailure'
        return 2
   
#    print 'samplingFailure'
    return 3

###################################################################################################################
################ OUTCOME_DCE #######################
##################################

def outcome_dce(input):
    if (os.path.getsize(input) == 0):
#        print input + " is empty."
#        print 'Did not finish'
        return 0
    file = open(input, 'r')
    lines = file.readlines()
    RMSDarray = []
    for line in lines:
        splitline = line.split()
        if len(splitline) >= 3:
           if splitline[1] == "HA_RMSDh:":
              rmsd = float(splitline[2])
           if splitline[2] == "Score:":
              nrg = float(splitline[3])
              RMSDarray.append([nrg, rmsd])

    score = [a[0] for a in RMSDarray]
    lowest_score = min(score)

    for entry in RMSDarray:
        if entry[0] == lowest_score:
            if entry[1] <= 2.0:
                return 1
            else:
                return 2
    return 2

###################################################################################################################
################ OUTCOME_FP ########################
##################################

def outcome_fp(input):
    if (os.path.getsize(input) == 0):
#        print input + " is empty."
#        print 'Did not finish'
        return 0
    file = open(input, 'r')
    lines = file.readlines()
    RMSDarray = []
    fps = 0
    for line in lines:
        splitline = line.split()
        if len(splitline) == 3:
           if splitline[1] == "HA_RMSDh:":
              rmsd = float(splitline[2])
              fps = 0
           if splitline[1] == "vdw_fp:":
              fps += float(splitline[2])
           if splitline[1] == "es_fp:":
              fps += float(splitline[2])
              RMSDarray.append([fps, rmsd])

    fps = [a[0] for a in RMSDarray]
    lowest_fps = min(fps)

    for entry in RMSDarray:
        if entry[0] == lowest_fps:
            if entry[1] <= 2.0:
                return 1
            else:
                return 2
    return 2


#################################################################################################################
######## MAIN ##########################################################
##################################

def main():

 dock_suc = 0
 scoring  = 0
 sampling = 0
 unfinished = 0
 if len(argv) !=3:
    print argv[0], "[FLX/RGD/FAD] ListFile"
    exit()
 function = argv[1]
 listFile = argv[2]
 #scoredFile = argv[2]

 systemsFile = open( listFile, 'r')

 systems = systemsFile.readlines()
 systemsFile.close()
# print N

 success_file=open("%s.dock6.SB2012.success.%s.dat" % (str(datetime.date.today()),function), "w")
 scoring_failure_file=open("%s.dock6.SB2012.scoring_failure.%s.dat" % (str(datetime.date.today()),function), "w")
 sampling_failure_file=open("%s.dock6.SB2012.sampling_failure.%s.dat" % (str(datetime.date.today()),function), "w")


 for sys in systems:
     sys = sys.rstrip()
     #out_grid = outcome_grid(sys+"/07a-mod_flex.dock/mod_flex.dock_scored.mol2") 
     #out_grid = outcome_grid(sys+"/04b-min_flag.dock/min_flag.dock_scored.mol2") 
     #out_grid = outcome_grid(sys+"/04-min_flag.dock/min_flag.dock_scored.mol2") 
     #out_grid = outcome_grid(sys+"/02-am1bcc.dock/am1bcc.dock_scored.mol2") 
     out_grid = outcome_grid(sys+"/"+function+"/"+sys+"."+function+"_scored.mol2") 
     if (out_grid == 1):
         dock_suc += 1
         success_file.write("%s\n" %sys)
         #print sys, "success"
     elif (out_grid == 2):
         scoring += 1
         scoring_failure_file.write("%s\n" % sys)
         #print sys, "scoring"
     elif (( out_grid == 3 ) or (out_grid == 0)):
         sampling += 1
         sampling_failure_file.write("%s\n" % sys)
         #print sys, "sampling"
         if ( out_grid == 0):
	     unfinished += 1
             print sys
     #out_heuc = outcome_fp(sys+"/half_euclidean_scored.mol2")
     #if (out_heuc == 1):
     #    heuc_suc += 1

     #out_eucl = outcome_fp(sys+"/euclidean_scored.mol2")
     #if (out_eucl == 1):
 
    #    eucl_suc += 1
 success_file.close()
 scoring_failure_file.close()
 sampling_failure_file.close()

 print len(systems), "Systems"
 print "Success", dock_suc, (dock_suc / float(len(systems)))*100
 print "Scoring", scoring, (scoring / float(len(systems)))*100
 print "Sampling", sampling, (sampling / float(len(systems)))*100
 print "Unfinished", unfinished, (unfinished / float(len(systems)))*100

###########################################
main()
###########################################

