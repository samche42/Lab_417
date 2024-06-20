#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=16
#SBATCH --mem 10G
#SBATCH --error=kofam.%J.err
#SBATCH --output=kofam.%J.out
#SBATCH --mail-user=your_email@gmail.com
#SBATCH --mail-type=ALL

cd /path/to/faa/files

source /home/USER_HERE/miniconda3/bin/activate kofamscan

for file in `ls *.faa`; do 

exec_annotation ${file} \
-o ${file/.faa/_kegg_output} \
-p /home/sam/Databases/kofamscan_db/db/profiles \
-k /home/sam/Databases/kofamscan_db/db/ko_list \
-f detail-tsv \
--cpu 16

done
