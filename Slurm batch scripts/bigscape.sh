#!/bin/bash
#SBATCH --partition=agrp
#SBATCH --time=14-00:00:00
#SBATCH -N 1 # Nodes
#SBATCH -n 1 # Tasks
#SBATCH --cpus-per-task=12
#SBATCH --mem 100G
#SBATCH --error=bigscape.%J.err
#SBATCH --output=bigscape.%J.out
#SBATCH --mail-user=you@gmail.com
#SBATCH --mail-type=ALL

source /home/sam/miniconda3/bin/activate bigscape

python /home/user/Tools/BiG-SCAPE/bigscape.py \
        --inputdir /path/to/your/folder/with/all/gbk/files \
        -–mix -v –-mode auto –-mibig –-cutoffs 0.5 –-include_singletons \
        --pfam_dir /home/sam/Databases \
        --cores 24 \
        --outputdir /path/to/your/folder/with/all/gbk/files/Bigscape_results
