#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=24
#SBATCH --mem 500G
#SBATCH --error=spades.%J.err
#SBATCH --output=spades.%J.out
#SBATCH --mail-user=your_email@gmail.com
#SBATCH --mail-type=ALL

cd /path/to/your/reads

spades.py -t 24 -m 500 \
        --iontorrent \
        --s1 IonCode_XXX_rawlib.basecaller.bam \
        -k 21,33,55,77,99,127 \
        -o Output_folder_name
