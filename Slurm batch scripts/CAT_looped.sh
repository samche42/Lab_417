#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=8
#SBATCH --mem 200G
#SBATCH --error=CAT.%J.err
#SBATCH --output=CAT.%J.out

cd /path/to/your/fasta/files

eval "$(conda shell.bash hook)"
conda activate CAT

for file in *.fasta; do
    prefix=${file/.fasta/}
    CAT contigs -c ${file} \
        -d /home/sam/Databases/20240422_CAT_nr/db \
        -t /home/sam/Databases/20240422_CAT_nr/tax \
        --out_prefix ${prefix} \
        --nproc 8 \
        --I_know_what_Im_doing \
        --top 11

    CAT add_names -i ${prefix}.contig2classification.txt \
        -o ${prefix}.official_names.txt \
        -t /home/sam/Databases/20240422_CAT_nr/tax \
        --only_official

    CAT summarise -c ${file} \
        -i ${prefix}.official_names.txt \
        -o ${prefix}.summary.txt

done

conda deactivate
