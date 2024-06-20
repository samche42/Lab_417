#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=8
#SBATCH --mem 100G
#SBATCH --error=antismash.%J.err
#SBATCH --output=antismash.%J.out
#SBATCH --mail-user=you@gmail.com
#SBATCH --mail-type=ALL

cd /path/to/MAGs/or/scaffolds

eval "$(conda shell.bash hook)"
conda activate antismash

for file in *.fasta
do
        antismash --taxon bacteria \
        --cb-general --cb-knownclusters \
        --asf --pfam2go --smcog-trees \
        --genefinding-tool prodigal ${file} \
        --cpus 8 \
        --output-dir ${file/.fasta/_antiSMASH_output}
done
