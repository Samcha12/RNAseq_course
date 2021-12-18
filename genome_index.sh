#!/bin/bash

#SBATCH --job-name="genome_indexed"
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --mem=8GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=am21t030@campus.unibe.ch

module add UHTS/Aligner/hisat/2.2.1;
hisat2-build /data/courses/rnaseq/toxoplasma_de/genome/Mus_musculus.GRCm39.dna.primary_assembly.fa mg_indexed

#run in shell : sbatch genome_index ....



