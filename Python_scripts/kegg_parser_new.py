#Usage: python3 kegg_parser.py -i path/to/kofamsccan/output -l Nitrogen_list -k kegg_control_file

import os
import sys
from csv import DictWriter
import argparse
import pandas as pd

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input_dir", help="Full file path to kegg input files")
parser.add_argument("-l", "--kegg_list", help="List of KO numbers to search for")
parser.add_argument("-k", "--pathways", help="KEGG control file")

args = parser.parse_args()

print( "Input_directory: {} KEGG_list: {} :KEGG_pathway_file {} ".format(
        args.input_dir,
        args.kegg_list,
        args.pathways,
        ))

#Read in kofamscan output from detailed run
kegg_files = [file for file in os.listdir(args.input_dir) if file.endswith("kegg_output_detailed")]

for kegg_file in kegg_files:
   output_file = kegg_file+"_reliable"
   output = open(output_file,'a')
   for line in open(kegg_file):
      if line.startswith('*'):
         output.write(line)
   output.close()

reliable_kegg_file = [file for file in os.listdir(args.input_dir) if file.endswith("_reliable")] #Read in newly created file with only reliable annotations
#Replace whitespaces with a tab
for rel_file in reliable_kegg_file:
   filepath_in = args.input_dir+"/"+rel_file
   filepath_out = args.input_dir+"/"+rel_file+"_tabbed"
   with open(filepath_in, 'r') as file_in, open(filepath_out, 'w') as file_out:
       for line in file_in:
           data = line.split()  # splits the content removing spaces and final newline
           line_w_tabs = "\t".join(data) + '\n'
           file_out.write(line_w_tabs)

#Read in and parse the tabbed file
tabbed_kegg_files = [file for file in os.listdir(args.input_dir) if file.endswith("_tabbed")]
for tab_file in tabbed_kegg_files:
   kegg_df = pd.read_csv(args.input_dir+"/"+tab_file,sep = '\t',usecols=[1,2,4],names=["Gene","KO","Score"]) #Read in tabbed file into pandas dataframe
   kegg_df_dups_removed = kegg_df.groupby(["Gene","KO"], as_index=False, sort=False)["Score"].max() #Keep annotation with highest score
   kegg_subset_df = kegg_df_dups_removed[["Gene","KO"]] #Convert to mapper output format
   final_file = args.input_dir+"/"+tab_file+"_final" #Generate empty output file
   kegg_subset_df.to_csv(final_file, sep='\t', index=False) #Write subsetted df to file

#Parse and summarize KO counts from all bins

#Convert search file to list
query_list = []
with open(os.path.join(args.input_dir, args.kegg_list)) as query_input:
        for line in query_input:
                query_list.append(line.strip("\n"))

#create list of kegg files to parse through
kegg_files = [file for file in os.listdir(args.input_dir) if file.endswith("final")]

#Create a dictionary for each genome, with all query KOs set to a count of 0.
ko_list = []
for kegg in kegg_files:
        ko_entries = []
        genome_dict = {"Genome": str(kegg)}
        for ko in query_list:
                genome_dict[ko] = 0
#Parse through each kofamscan_outputfile per genome
        with open(os.path.join(args.input_dir, kegg)) as input:
                for line in input:
                        if len(line.split("\t")) == 1: #if there is no KO annotation for this gene, ignore it
                                pass
                        else:
                                gene, ko = line.strip("\n").split("\t")
                                ko_entries.append(ko) #Add KO to list
        input.close()
        for ko_entry in ko_entries:
                if ko_entry in genome_dict:
                        genome_dict[ko_entry] += 1
                else:
                        pass
        ko_list.append(dict(genome_dict)) #Append new dictionary to overall list

#Write it out to a file
keys = ko_list[0].keys()
with open((os.path.join(args.input_dir,"KEGG_output_count_table.txt")),"w") as output:
        dict_writer = DictWriter(output, keys, delimiter = "\t")
        dict_writer.writeheader()
        for item in ko_list:
                dict_writer.writerow(item)
output.close()

#Read in count file
sample_KO_matrix_df = pd.read_csv('KEGG_output_count_table.txt', sep="\t", header=0)
clean_sample_KO_matrix_df = sample_KO_matrix_df.replace("without_pseudos_kegg_output_detailed_reliable_tabbed_final","",regex=True)
#transpose count file
clean_sample_KO_matrix_df_t = clean_sample_KO_matrix_df.set_index('Genome').transpose()
clean_sample_KO_matrix_df_t.reset_index(inplace = True)
clean_sample_KO_matrix_df_t = clean_sample_KO_matrix_df_t.rename(columns={'index': 'KO'})
#Read in control file
KEGG_control = pd.read_csv(args.input_dir+'/'+args.pathways, sep="\t", header=0)
#Merge dataframes
KEGG_control_df = pd.merge(KEGG_control,clean_sample_KO_matrix_df_t,on='KO',how='outer')
#Write to file
KEGG_control_df.to_csv(args.input_dir+'/KO_pathway_count_summary.tab', sep='\t', index=False)

#Delete interim files
int_files = os.listdir(args.input_dir)
for int_file in int_files:
    if int_file.endswith(("_reliable","_tabbed","final","_output_count_table.txt")):
        os.remove(os.path.join(args.input_dir, int_file))
