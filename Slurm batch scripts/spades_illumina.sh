#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=24
#SBATCH --mem 500G
#SBATCH --error=spades.%J.err
#SBATCH --output=spades.%J.out

cd /path/to/reads

python3 /home/USER_HERE/Tools/SPAdes-3.15.0-Linux/bin/spades.py -t 24 -m 500 \
        --pe1-1 fwd_reads.fastq --pe1-2 rev_reads.fastq \
        -o RENAME_ME_Spades_Assembly

#NOTE: CHANGE PATH TO SPADES TO WHEREVER YOU DOWNLOADED YOURS
