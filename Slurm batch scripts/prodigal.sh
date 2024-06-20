#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=10
#SBATCH --mem 10G
#SBATCH --error=prokka.%J.err
#SBATCH --output=prokka.%J.out
#SBATCH --mail-user=your_email@gmail.com
#SBATCH --mail-type=ALL

cd /path/to/your/MAGs

source /home/USER_NAME_HERE/miniconda3/bin/activate prodigal

for genome_bin in `ls *.fasta`
do
        prodigal -i ${genome_bin} -a ${genome_bin/.fasta/.faa} -f gff -p meta -o ${genome_bin/.fasta/.gff}
done
