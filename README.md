# Lab_417
All batch scripts and installation instructions for Lab 417

## Conda env installation instructions

### GTDB-Tk
```
conda create -y -n gtdbtk
conda activate gtdbtk
conda install -y -c conda-forge -c bioconda gtdbtk=2.4.0
conda env config vars set GTDBTK_DATA_PATH="/home/sam/Databases/release220"
conda deactivate
```

### CheckM2
```
create -y -n checkm2 -c bioconda -c conda-forge checkm2 'python>=3.7, <3.9'
```

### antiSMASH
```
conda create -y -n antismash
conda activate antismash
conda install -y -c bioconda -c conda-forge antismash=7.1.0
conda deactivate
```

### Prokka
```
conda create --name prokka
conda activate prokka
conda install -y -c biobuilds perl=5.22
conda install -y -c conda-forge parallel
conda install -y -c bioconda prodigal blast tbl2asn prokka
conda deactivate
```

### Diamond blastp
```
conda create -y -n blastp
conda activate blastp
conda install -y bioconda::diamond
```

### KoFamSCAN
```
conda create --name kofamscan
conda activate kofamscan 
conda install -y -c bioconda kofamscan hmmer
conda install -y -c conda-forge ruby parallel
conda deactivate
```

### BiG-SCAPE
```
cd Tools
git clone https://git.wur.nl/medema-group/BiG-SCAPE.git
cd BiG-SCAPE/
conda env create -f environment.yml
```

### Samtools
```
conda create --name samtools
conda activate samtools
conda install -y -c bioconda samtools
conda deactivate
```

### Autometa 2.0
```
conda create -y -n autometa
conda activate autometa
conda install -y -c bioconda -c conda-forge autometa
autometa-config --section databases --option markers --value /home/sam/Databases/autometa_markers #Note: Leave this path as is, do not change it to your user name
autometa-config --section databases --option ncbi --value /home/sam/Databases/autometa_ncbi_sam #Same here - leave it as is
```

#### Autometa Slurm script
I've created a slurm script for Autometa that uses flagged parameter input so that you can run several jobs on different data simultaneously. The slurm script is saved in the scripts folder under autometa_flagged.sh. You can submit it to the slurm scheduler with:

```
sbatch autometa_flagged.sh \
-o /path/to/where/output/should/go \
-a /path/to/scaffolds.fasta \
-s basename_of_choice \
-n /home/sam/Databases/autometa_ncbi_sam \
-m /home/sam/Databases/autometa_markers \
-l 3000 -v spades -c 8
```

Example:

```
sbatch autometa_flagged.sh \
-o /home/sam/Autometa_test_run \
-a /home/sam/Autometa_test_run/003D_scaffolds.fasta \
-s Test_run_output \
-n /home/sam/Databases/autometa_ncbi_sam \
-m /home/sam/Databases/autometa_markers \
-l 3000 -v spades -c 8
```

**NB:** If you would like to change the number of CPUs used per job, you'll have to change this number next to the ```-c``` flag AND within the ```#SBATCH --ntasks-per-node=16``` line in the autometa_flagged.sh file. 

### Delete a conda env and everything in it
```
conda env remove --name name_of_env_here
```
