#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=10
#SBATCH --mem 16G
#SBATCH --error=blastp.%J.err
#SBATCH --output=blastp.%J.out
#SBATCH --mail-user=your_email@gmail.com
#SBATCH --mail-type=ALL

cd /path/to/where/faa/files/are

eval "$(conda shell.bash hook)"
conda activate blastp

for file in `ls *.faa`

do

diamond blastp -d /home/sam/Databases/autometa_ncbi_sam/nr.dmnd -q ${file} -\
k 1 --max-hsps 1 --outfmt 6 qseqid stitle pident evalue qlen slen -o ${file/.faa/_blast.tab}

done

conda deactivate
