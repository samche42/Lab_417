#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=10
#SBATCH --mem 16G
#SBATCH --error=blastp.%J.err
#SBATCH --output=blastp.%J.out
#SBATCH --mail-user=samche42@gmail.com
#SBATCH --mail-type=ALL

cd /path/to/faa/files

source /home/sam/miniconda3/bin/activate diamond

for file in `ls *.faa`

do

diamond blastp -d /home/sam/Databases/nr.dmnd -q ${file} -\
k 1 --max-hsps 1 --outfmt 6 qseqid stitle pident evalue qlen slen -o ${file/.faa/_blast.tab}

done

conda deactivate
