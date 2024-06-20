#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=10
#SBATCH --mem 5G
#SBATCH --error=logs/checkm.%J.err
#SBATCH --output=logs/checkm.%J.out

source /home/USER_HERE/miniconda3/bin/activate checkm2

cd /home/sam/Temp_actinos

checkm2 predict --input path/to/your/MAGs --output-directory path/to/where/your/output/should/go \
--threads 10 --database_path /home/sam/Databases/CheckM2_database/uniref100.KO.1.dmnd \
--remove_intermediates --extension fasta

conda deactivate
