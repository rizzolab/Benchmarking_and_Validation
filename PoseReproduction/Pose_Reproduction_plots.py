from sys import argv
import os
import csv
import matplotlib.pyplot as plt
import numpy as np

##################################################################################################################################
###################### Sort Results of answers ####################################################################################
################################################################################################################################
#THis is a general sort function to organize success, scoring, and sampling

def sort_results(results, sort_results):
    for res in results:
        if res=="Success":
            sort_results[0]=sort_results[0]+1
        elif res=="Scoring Failure":
            sort_results[1]=sort_results[1]+1
        elif res=="Sampling Failure":
            sort_results[2]=sort_results[2]+1
    return sort_results

############################################################################################################################
################## Average Time of DOCK ####################################################################################
########################################################################################################################

def average_time(total, times):
    i=0
    while i<len(total):
        if total[i]!=0:
            times[i]=times[i]/total[i]
        else:
            times[i]=0
        i=i+1
    return times

####################################################################################################################
####################### autolabel bar charts #######################################################################
####################################################################################################################

def autolabel(rects, plot):
    """Attach a text label above each bar in *rects*, displaying its height."""
    for rect in rects:
        height = rect.get_height()
        plot.annotate('{}'.format(height),
                      xy=(rect.get_x() + rect.get_width() / 2, height),
                      xytext=(0, 3),  # 3 points vertical offset
                      textcoords="offset points",
                      ha='center', va='bottom', size=8)


#################################################################################################################################
################################### Pie Chart Result ##########################################################################
###############################################################################################################################

#raw_data=open(csv_file,"r")
def generate_pie(graph, results):
    pie_data=[0,0,0]
    pie_data=sort_results(results,pie_data)
    pie_labels=[str(pie_data[0])+" Successful systems",str(pie_data[1])+" Scoring Failures",str(pie_data[2])+" Sampling Failure"]
    graph.pie(pie_data,labels=pie_labels,shadow=True, autopct='%.2f%%')
    graph.title("DOCK Results")

######################################################################################################################
##################### Linear Plot based on Success rate on Rotatable bonds############################################
#####################################################################################################################


def scatter_rot(graph,results,rotable):
    total_rotatable=[]
    success_rotatable=[]
    i=0
    while i<40:
        total_rotatable.append(0)
        success_rotatable.append(0)
        i+=1
    i=1
    while i<len(rotable):
        if rotable[i]!="N/A" and int(rotable[i])<40:
            total_rotatable[int(rotable[i])]=total_rotatable[int(rotable[i])]+1
            if results[i]=="Success":
                success_rotatable[int(rotable[i])]=success_rotatable[int(rotable[i])]+1
        i=i+1
    rot_success_rate=[]
    num_rot=[]
    s=[]
    rot_value=[]
    x_value=[]
    i=0
    while i<40:
        if total_rotatable[i]!=0:
            num_rot.append(i)
            rot_success_rate.append(round(success_rotatable[i]/total_rotatable[i],4)*100)
            s.append(total_rotatable[i] * 4)
            rot_value.append(total_rotatable[i])
    #    times_rotatable[i]=times_rotatable[i]/total_rotatable[i]
    #    print(times_rotatable[i])
        if i%2==0:
            x_value.append(i)
        i=i+1
    i=0
    for x, y in zip(num_rot,rot_success_rate):
        label = "{:.1f}".format(y)
        label = label + "%, " + str(rot_value[i])
        i=i+1
        graph.annotate(label,  # this is the text
            (x, y),  # this is the point to label
            textcoords="offset points",  # "offset points",  # how to position the text
            arrowprops=dict(arrowstyle="->", connectionstyle="angle3"),
            xytext=(0, max(num_rot)),  # distance from text to points (x,y)
            va="center", ha='center',rotation=60,
            size=6)  # horizontal alignment can be left, right or center
    graph.scatter(num_rot,rot_success_rate,s)
    graph.set_title("Rotable Bond Success Rate", pad=12.0)
    graph.set_xticks(x_value)
    graph.set_yticks([0,20,40,60,80,100])
    graph.set_ylabel("Success Rate")
    graph.set_xlabel("# of Rot")
    graph.grid()

#############################################################################################################################
############################## Linear Plot based on time of Rotatable bonds##################################################
###########################################################################################################################

def RMSD_time_Scatter(graph, rotable, times):
    times_rotatable = []
    total_rotatable=[]
    num_rot=[]
    xticks=[]
    i = 0
    while i < 40:
        total_rotatable.append(0)
        times_rotatable.append(0)
        num_rot.append(i)
        if (i%2==0):
            xticks.append(i)
        i += 1
    i = 1
    times_rotatable2=[]
    while i<len(rotable):
        if rotable[i]!="N/A" and int(rotable[i])<40 and times[i]!="N/A":
           #print(rotable[i])
            total_rotatable[int(rotable[i])]=total_rotatable[int(rotable[i])]+1
            times_rotatable[int(rotable[i])]=times_rotatable[int(rotable[i])]+int(times[i])
        #    s.append(total_rotatable[int(rotable[i])] * 4)
        i=i+1
    i=0
    s=[]
    while i<len(total_rotatable):
        if total_rotatable[i]!=0 and int(rotable[i])<40 and times[i]!="N/A":
            times_rotatable2.append(times_rotatable[i]/total_rotatable[i])
        else:
            times_rotatable2.append(0)
        s.append(total_rotatable[i] * 4)
        i=i+1
    #print(len(times_rotatable))
    #print(times_rotatable)
    #print(len(total_rotatable))
    #print(total_rotatable)
    #print(len(times_rotatable2))
    #print(times_rotatable2)
    #print(num_rot)
    i=0
    for x, y in zip(num_rot,times_rotatable2):
        label = "{:.1f}".format(y)
        label = label + "s, " + str(total_rotatable[i])
        i=i+1
        graph.annotate(label,  # this is the text
            (x, y),  # this is the point to label
            textcoords="offset points",  # "offset points",  # how to position the text
            arrowprops=dict(arrowstyle="->", connectionstyle="angle3"),
            xytext=(0, max(num_rot)),  # distance from text to points (x,y)
            va="center", ha='center',rotation=60,
            size=6)  # horizontal alignment can be left, right or center

    times=average_time(total_rotatable,times_rotatable)
    graph.scatter(num_rot,times,s)
    graph.set_title("Average time vs. # of Rot Bonds")
    graph.set_xticks(xticks)
    graph.set_ylabel("Docking time(sec)")
    graph.set_xlabel("# of Rot bonds")
    graph.grid()

######################################################################################################################
######################### Rotatable Bonds scatter plot based on time ##############################################
######################################################################################################################

def rotable_time(graph, rotable, times):
    times_rotatable = []
    total_rotatable=[]
    num_rot=[]
    xticks=[]
    i = 0
    while i < 40:
        total_rotatable.append(0)
        times_rotatable.append(0)
        num_rot.append(i)
        if (i%2==0):
            xticks.append(i)
        i += 1
    i = 1
    while i<len(rotable):
        if rotable[i]!="N/A" and int(rotable[i])<40 and times[i]!="N/A":
           #print(rotable[i])
            total_rotatable[int(rotable[i])]=total_rotatable[int(rotable[i])]+1
            times_rotatable[int(rotable[i])]=times_rotatable[int(rotable[i])]+int(times[i])
        i=i+1
    times=average_time(total_rotatable,times_rotatable)
    graph.bar(num_rot,times)
    graph.set_title("Average time vs. # of Rot Bonds")
    graph.set_xticks(xticks)
    graph.set_ylabel("Docking time(sec)")
    graph.set_xlabel("# of Rot bonds")
########################################################################################################################
############################ RMSD Scatter Plot #######################################################################
######################################################################################################################

def RMSD_Scatter(graph,RMSD,results):
    i=0
    percentage=[]
    rmsd=[]
    result=[]
    while len(RMSD)>i:
        if RMSD[i]!="N/A" and RMSD[i]!="-1000.0":
            percentage.append((i / len(RMSD)) * 100)
            rmsd.append(float(RMSD[i]))
            result.append(results[i])
            RMSD[i]=float(RMSD[i])
        i=i+1
    rmsd.sort()
    graph.scatter(rmsd,percentage)
    graph.set_title("Best RMSDh vs. Percent of Systems")
    graph.set_ylabel("Percent of Systems")
    graph.set_xlabel("RMSDh")

##################################################################################################################
############################# bar plot success rate based on number of rotable bonds #############################
##################################################################################################################

def barplot_rot(graph, rotable, result):
    success=[]
    scoring=[]
    sampling=[]
    total=[]
    bin=[]
    i=0
    while 40>i:
        success.append(0)
        scoring.append(0)
        sampling.append(0)
        total.append(0)
        bin.append(i)
        i=i+1
    i=0
    while len(rotable)>i:
        if rotable[i]!="N/A":
            if result[i]=="Success":
                success[int(rotable[i])]=success[int(rotable[i])]+1
            elif result[i]=="Scoring Failure":
                scoring[int(rotable[i])]=scoring[int(rotable[i])]+1
            elif result[i]=="Sampling Failure":
                sampling[int(rotable[i])]=sampling[int(rotable[i])]+1
            total[int(rotable[i])]=total[int(rotable[i])]+1
        i=i+1
    i=0
    x_label=[]
    while len(success)>i:
        if total[i]!=0:
            success[i]=success[i]/total[i]*100
            scoring[i]=scoring[i]/total[i]*100
            sampling[i]=sampling[i]/total[i]*100
        if i%2==0:
            x_label.append(i)
        i=i+1
    n=40
    width=0.9
    pos=np.arange(40)
    labels=["Success","Scoring Failure","Sampling Failure"]
    plt1=graph.bar(pos,height=success, width=width, color="green", align="center",label="Success")
    plt2=graph.bar(pos,scoring,width=width, color="orange", align="center",label="Scoring Failure")
    plt3=graph.bar(pos,sampling,width=width, color="red",align="center", label="Sampling Failure")
    graph.set_xlim(-1,40)
    graph.set_xticks(x_label)
    graph.set_title("Success rate dependent on rotatable bonds")
    graph.set_ylabel("Percentage(%)")
    graph.set_xlabel("# of Rotatable Bonds")
    graph.legend(loc="upper right", fontsize=6)

######################################################################################################################
################### multiple ion bar plot ###################################################################3
#############################################################################################################

#Creates a general bar plot of all the information
def bar_plot_general(graph,info, results):
    ions = [[], [], []]
    no_ions = [0, 0, 0]
    single_ion = [0, 0, 0]
    multiple_ion = [0, 0, 0]
    i = 0
    while len(info) > i:
        values = info[i].split("/")
        if len(values) == 1 and results[i] != "N/A":
            ions[0].append(results[i])
        elif len(values) == 2 and results[i] != "N/A":
            ions[1].append(results[i])
        elif results[i] != "N/A":
            ions[2].append(results[i])
        i = i + 1
    no_ions = sort_results(ions[0], no_ions)
    single_ion = sort_results(ions[1], single_ion)
    multiple_ion = sort_results(ions[2], multiple_ion)
    total = [no_ions[0] + no_ions[1] + no_ions[2], single_ion[0] + single_ion[1] + single_ion[2],
             multiple_ion[0] + multiple_ion[1] + multiple_ion[2]]
    print(no_ions)
    print(single_ion)
    print(multiple_ion)
    print(total)
    i = 0
    while i < 3:
        no_ions[i] = round((no_ions[i] / total[0]) * 100, 2)
        try:
            single_ion[i] = round((single_ion[i] / total[1]) * 100, 2)
        except:
            print("No single ions")
        try:
            multiple_ion[i] = round((multiple_ion[i] / total[2]) * 100, 2)
        except:
           print("No multiple ions")
        i = i + 1
    X = np.arange(3)
    bar1 = graph.bar(X + 0.0, [no_ions[0], single_ion[0], multiple_ion[0]], color="green", width=0.25, align="center",
                     label="Success")
    bar2 = graph.bar(X + 0.25, [no_ions[1], single_ion[1], multiple_ion[1]], color="orange", width=0.25, align="center",
                     label="Scoring Failure")
    bar3 = graph.bar(X + 0.5, [no_ions[2], single_ion[2], multiple_ion[2]], color="red", width=0.25, align="center",
                     label="Sampling Failure")
    labels = ["no ion", "single ion", "multiple ion"]
    autolabel(bar1, graph)
    autolabel(bar2, graph)
    autolabel(bar3, graph)
    graph.legend()
    # graph.set_xticks(["No Ions","Single Ions","Multiple Ions"])
    graph.set_yticks([0, 20, 40, 60, 80, 100])
    graph.set_xticklabels(labels)
    graph.set_xticks(X+0.25)
    # graph.set_xticklabels(["No Ions","Single Ions","Multiple Ions"])
    graph.set_xlabel("# of Ions in systems")
    graph.set_ylabel("Percentage(%) of results")
    graph.set_title("Success dependent on the # of Ions")

########################################################################################################################
########################## Each Ion type ###############################################################################
######################################################################################################################

def bar_plot_each_ion(graph,info,results):
    ions = [[], [], [],[],[],[],[]]
    Zn = [0, 0, 0]
    Mg = [0, 0, 0]
    Mn = [0, 0, 0]
    K = [0, 0, 0]
    Na = [0,0,0]
    Cl=[0,0,0]
    Ca=[0,0,0]
    i = 0
    while len(info) > i:
        values = info[i].split("/")
        if len(values) == 2 and results[i] != "N/A":
            if "Zn" in values[0]:
                ions[0].append(results[i])
            if "Mg" in values[0]:
                ions[1].append(results[i])
            if "Mn" in values[0]:
                ions[2].append(results[i])
            if "K" in values[0]:
                ions[3].append(results[i])
            if "Na" in values[0]:
                ions[4].append(results[i])
            if "Cl" in values[0]:
                ions[5].append(results[i])
            if "Ca" in values[0]:
                ions[6].append(results[i])
        i = i + 1
    Zn = sort_results(ions[0], Zn)
    Mg = sort_results(ions[1], Mg)
    Mn = sort_results(ions[2], Mn)
    K=sort_results(ions[3],K)
    Na=sort_results(ions[4],Na)
    Cl=sort_results(ions[5],Cl)
    Ca=sort_results(ions[6],Ca)
    total = [Zn[0] + Zn[1] + Zn[2], Mg[0] + Mg[1] + Mg[2],Mn[0] +Mn[1] +Mn[2], K[0]+K[1]+K[2],Na[0]+Na[1]+Na[2],Cl[0]+Cl[1]+Cl[2],
             Ca[0]+Ca[1]+Ca[2]]
    def success_ion(ion, tot):
        i=0
        while i<3:
            if tot==0:
                ion[i]=0
            else:
                ion[i]=round((ion[i]/tot)*100,2)
            i=i+1
        return ion
    Zn = success_ion(Zn,total[0])
    Mg = success_ion(Mg,total[1])
    Mn=success_ion(Mn,total[2])
    K=success_ion(K,total[3])
    Na=success_ion(Na,total[4])
    Cl=success_ion(Cl,total[5])
    Ca=success_ion(Ca,total[6])
    i=0
    results=[]
    while i<3:
        results.append([Zn[i],Mg[i],Mn[i],K[i],Na[i],Cl[i],Ca[i]])
        i=i+1
    X = np.arange(7)
    bar1 = graph.bar(X + 0.0, results[0], color="green", width=0.25,
                     align="center", label="Success")
    bar2 = graph.bar(X + 0.25, results[1], color="orange", width=0.25,
                     align="center", label="Scoring Failure")
    bar3 = graph.bar(X + 0.5, results[2], color="red", width=0.25, align="center",
                     label="Sampling Failure")
    labels = ["Zn","Mg","Mn","K","Na","Cl","Ca"]
    autolabel(bar1, graph)
    autolabel(bar2, graph)
    autolabel(bar3, graph)
    graph.set_xticks(X+0.25)
    graph.legend()
    # graph.set_xticks(["No Ions","Single Ions","Multiple Ions"])
    graph.set_yticks([0, 20, 40, 60, 80, 100])
    graph.set_xticklabels(labels)
    # graph.set_xticklabels(["No Ions","Single Ions","Multiple Ions"])
    graph.set_xlabel("Single Ion Type")
    graph.set_ylabel("Percentage(%) of results")
    graph.set_title("Success dependent on Single Ion Type", size="large")

#######################################################################################################################
###################### Molecular Weight Success Rate ##################################################################
#####################################################################################################################

#The graph represents which subplot
#info represents all the MW weights
#results represents all the success rates based on all the results
def success_MW(graph,info, results):
    i=0
    MW=[]
    result=[]
    while len(info)>i:
        if info[i]!="N/A":
            MW.append(float(info[i]))
            result.append(results[i])
        i=i+1
    #int() function rounds values down, max gets the max float on the list
    MAX=int(max(MW)/50)
    MW_results=[]
    i=0
    while i<MAX+1:
        MW_results.append([0,0])
        i=i+1
    while len(MW)>i:
        MW_results[int(MW[i]/50)][1]=MW_results[int(MW[i]/50)][1]+1
        if result[i]=="Success":
            MW_results[int(MW[i]/50)][0]=MW_results[int(MW[i]/50)][0]+1
        i=i+1
    MW_SCATTER=[]
    MW_list=[]
    X_LABEL=[]
    MW_values=[]
    s=[]
    i = 0
    while i < MAX+1:
        if MW_results[i][1]==0:
            print("N/A")
        else:
            MW_SCATTER.append(round(MW_results[i][0]/MW_results[i][1], 4) * 100)
            MW_list.append(i*50)
            s.append(MW_results[i][1]*4)
            MW_values.append(MW_results[i][1])
        if i%2==0:
            X_LABEL.append(i*50)
        i=i+1
    i=0
    for x, y in zip(MW_list,MW_SCATTER):
        label = "{:.1f}".format(y)
        label=label+"%, "+str(MW_values[i])
        graph.annotate(label,  # this is the text
                     (x, y),  # this is the point to label
                     textcoords="offset points",  # how to position the text
                     xytext=(0, MAX+1),  # distance from text to points (x,y)
                     ha='center', size=6, rotation=60)  # horizontal alignment can be left, right or center
        i=i+1
    graph.scatter(MW_list,MW_SCATTER,s)
    graph.set_xticks(X_LABEL)
    graph.set_ylabel("Success Rate Percentage(%)")
    graph.set_xlabel("Ligand molecular weight(g/mol)")
    graph.set_title("Ligand Molecular Weight Success Rate", size="large")
    graph.grid()

#########################################################################################################################
########################### Time dependent on MW ############################################################################
#######################################################################################################################

def time_MW(graph, info,time):
    i=0
    MW=[]
    result=[]
    while i<len(info):
        if info[i]!="N/A" and time[i]!="N/A":
            MW.append(float(info[i]))
            result.append(float(time[i]))
        i=i+1
    if len(MW)>0:
        MAX = int(max(MW) / 50)
    else:
        MAX=0
    MW_results = []
    i = 0
    while i < MAX + 1:
        MW_results.append([0, 0])
        i = i + 1
    while len(MW) > i:
        MW_results[int(MW[i] / 50)][1] = MW_results[int(MW[i] / 50)][1] + 1
        MW_results[int(MW[i] / 50)][0] = MW_results[int(MW[i] / 50)][0] + result[i]
        i = i + 1
    MW_SCATTER = []
    MW_list = []
    MW_values=[]
    X_value = []
    s = []
    i = 0
    while i < MAX + 1:
        if MW_results[i][1] == 0:
            print("N/A")
        else:
            MW_SCATTER.append(round(MW_results[i][0] / MW_results[i][1], 4))
            MW_list.append(i * 50)
            s.append(MW_results[i][1] * 4)
            MW_values.append(MW_results[i][1])
        if i % 2 == 0:
            X_value.append(i * 50)
        i = i + 1
    i=0
    for x, y in zip(MW_list,MW_SCATTER):
        label = "{:.1f}".format(y)
        label=label+"%, "+str(MW_values[i])
        i=i+1
        graph.annotate(label,  # this is the text
                     (x, y),  # this is the point to label
                     textcoords="offset points",  # how to position the text
                     xytext=(0, MAX+1),  # distance from text to points (x,y)
                     ha='center', size=6, rotation=60)  # horizontal alignment can be left, right or cente

    graph.scatter(MW_list, MW_SCATTER, s)
    graph.set_xticks(X_value)
    graph.set_ylabel("Time(sec)")
    graph.set_xlabel("Ligand molecular weight(g/mol)")
    graph.set_title("Time dependent on Molecular Weight of ligand",size="large")
    graph.grid()


#######################################################################################################################
############################### Success Weight based on Molecular Weight ##############################################
#####################################################################################################################

#    i=0
#while len(mol_weight)>i:
#    if mol_weight[i]!="N/A" and float(mol_weight[i])<100:
#        print(mol_weight[i])
#    elif mol_weight[i]=="N/A":
#        i=i+1
#    i=i+1

#########################################################################################################################
################ MAIN ##################################################################################################
########################################################################################################################

def main():
#    try:
    csv_file = argv[1]
    graphs = argv[2]
        # raw_data = open("DOCK6.9_pose_reproduction.csv", "r")
    raw_data = open(csv_file, "r")
    processed_data = raw_data.readlines()
    raw_data.close()
        # fig, axs = plt.subplots(3, 2)
    results = []
    rot_bonds = []
    mol_weight = []
    time = []
    RMSD = []
    grid_score = []
    ions = []
    i = 1
    while len(processed_data) > i:
        values = processed_data[i].split(",")
        print(values)
        results.append(values[1])
        rot_bonds.append(values[7])
        mol_weight.append(values[8])
        time.append(values[6])
        grid_score.append(values[3])
        RMSD.append(values[2])
        ions.append(values[29])
        print(values[29])
        i = i + 1
    if graphs == "1":
        print("This pie chart doesn't include unfinished systems")
            # fig, ax = plt.subplot(0,0)
        generate_pie(plt, results)
        average_time=0
        total=0
        for sys in time:
            try:
                average_time=average_time+(float(sys))
                total=total+1
            except:
                print("")
        print("The average time for all docking experiments is "+str(average_time/total))
        plt.show()
    if graphs == "2":
        fig, axs = plt.subplots(2, 2)
        scatter_rot(axs[0, 0], results, rot_bonds)
        rotable_time(axs[0, 1], rot_bonds, time)
        #RMSD_Scatter(axs[1, 0], RMSD, results)
        RMSD_time_Scatter(axs[1,0], rot_bonds, time)
        barplot_rot(axs[1, 1], rot_bonds, results)
        fig.tight_layout(pad=0.5)
        plt.show()
    if graphs == "3":
        fig, axs = plt.subplots(2, 2)
        bar_plot_general(axs[0, 0], ions, results)
        bar_plot_each_ion(axs[0, 1], ions, results)
        success_MW(axs[1, 0], mol_weight, results)
        RMSD_Scatter(axs[1, 1], RMSD, results)
        #time_MW(axs[1, 1], mol_weight, time)
        fig.tight_layout(pad=0.5)
        plt.show()
#    except:
#        print("Analysis script failed, check parameters")
#        print("Arguement 1 is the csv file\nexample: DOCK6.csv")
#        print("Arguement 2 is the type of graph to produce")
#        print("\"1\" is creates a pie chart of the success rate")
#        print("\"2\" creates a subplot based on the  #  of rotatable bonds and RMSDh")
#        print("\"3\" Creates a subplot based on the # of ions and Molecular Wieght")
#        print("Make sure that you are using python 3")
main()
