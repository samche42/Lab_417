#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=10
#SBATCH --mem 16G
#SBATCH --error=trimmomatic.%J.err
#SBATCH --output=trimmomatic.%J.out

cd /path/to/raw/Illumina/reads

trimmomatic PE -baseout your_sample_name_here.fastq \
fwd_reads.fastq rev_reads.fastq \
ILLUMINACLIP:/home/sam/miniconda3/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic/adapters/TruSeq3-PE.fa:2:30:10 \
MINLEN:25
