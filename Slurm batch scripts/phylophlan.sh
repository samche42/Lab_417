#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --mem 100G
#SBATCH --cpus-per-task=36
#SBATCH --error=phylophlan.%J.err
#SBATCH --output=phylophlan.%J.out

cd /path/to/phylophlan/input/files

eval "$(conda shell.bash hook)"
conda activate phylophlan

phylophlan -i Input_folder -o Phylophlan_output -d phylophlan --diversity low -f supermatrix_aa.cfg --nproc 36

conda deactivate
