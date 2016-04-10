# -*- coding: utf-8 -*-
"""
Created on Sun Apr 10 16:03:53 2016

@author: Kayla
"""

import pandas as pd

hier_file = "anon_hierarchy_el_top3.csv"
data = pd.read_csv(hier_file, sep=" ", header=0)

status_list = ['GradStudent', 'Research', 'PM', 'Director']

# create an index decoder by making a list
# of anonymous indexes for each status type
idx_decoder = {}
for status in status_list:
    data_subset = data[data['pid1_Status']==status]
    id_list = list(set(data_subset['pid1'].tolist()))
    idx_decoder[status] = id_list
    
# now, create the arrays to use for Matlab
# in each array, the first row represents the 
# strongest upwards connection for each person
# the second row represents the 2nd strongest 
# upwards connection, etc.
for idx in xrange(len(status_list[:-1])):
        status = status_list[idx]
        next_status = status_list[idx+1]
        data_subset = data[data['pid1_Status']==status]
        data_subset = data_subset[data_subset['pid2_Status']==next_status]
        output_array = pd.DataFrame()
        decoder = idx_decoder[next_status]
        for person in idx_decoder[status]:
            top_people = (data_subset[data_subset['pid1']==person]['pid2']).tolist()
            top_people_idx = []            
            for each_val in top_people:
                top_people_idx.append(decoder.index(each_val))
            # if there aren't three people, add -1's
            while len(top_people_idx) < 3:
                top_people_idx.append(-1)
            top_people_df = pd.DataFrame(top_people_idx)
            output_array = pd.concat([output_array, top_people_df], axis=1)
        output_array.to_csv(status+"_array.csv", header=False, index=False)