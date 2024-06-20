#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=10
#SBATCH --mem 10G
#SBATCH --error=prokka.%J.err
#SBATCH --output=prokka.%J.out

cd /path/to/MAGs

source /home/USER_HERE/miniconda3/bin/activate prokka

for genome in `ls *.fasta`
do
        prokka \
        --centre X --compliant --outdir ${genome/.fasta/''} \
        --locustag ${genome/.fasta/''} --prefix ${genome/.fasta/''} ${genome}
done
