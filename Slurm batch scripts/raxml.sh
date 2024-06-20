#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=8
#SBATCH --mem 50G
#SBATCH --error=logs/raxml.%J.err
#SBATCH --output=logs/raxml.%J.out

cd /path/to/Phylophlan_output

eval "$(conda shell.bash hook)"
conda activate phylophlan

raxmlHPC-PTHREADS-SSE3 -s your_sample_concatenated.aln -n name_of_tree_here.nwk -f a -m PROTGAMMAAUTO -N 1000 -p 42 -x 42 -T 8

conda deactivate
