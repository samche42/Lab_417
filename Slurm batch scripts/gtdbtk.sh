#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=16
#SBATCH --mem 100G
#SBATCH --error=logs/gtdbtk.%J.err
#SBATCH --output=logs/gtdbtk.%J.out

source /home/USER_HERE/miniconda3/bin/activate gtdbtk

cd /home/sam/Temp_actinos

gtdbtk classify_wf --genome_dir /path/to/where/your/MAGs/are \
--mash_db /home/sam/Databases \
--extension fasta --out_dir /path/to/where/your/output/should/go \
--cpus 16 --pplacer_cpus 1

conda deactivate
