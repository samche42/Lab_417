#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=10
#SBATCH --mem 16G
#SBATCH --error=blastn.%J.err
#SBATCH --output=blastn.%J.out
#SBATCH --mail-user=your_email@gmail.com
#SBATCH --mail-type=ALL

cd /path/to/query/file

source /home/USER_NAME_HERE/miniconda3/bin/activate blastn

blastn -db /home/sam/Databases/nt_DB/nt_prok -query your_file_of_queries_here.fasta \
        -outfmt 6 -out your_output_filename_here_blast.txt \
        -max_hsps 1 -max_target_seqs 1 -num_threads 10

conda deactivate
