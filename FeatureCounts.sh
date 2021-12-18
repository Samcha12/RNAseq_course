#!/bin/sh
#SBATCH --job-name="Reads_counting"
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --mem=1GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=am21t030@campus.unibe.ch

module add UHTS/Analysis/subread/2.0.1;

featureCounts -T 4 -s 2 \
  -a /data/courses/rnaseq/toxoplasma_de/annotation/Mus_musculus.GRCm39.104.gtf \
  -o /data/courses/rnaseq/toxoplasma_de/AM_workplace/Reads_counting/output_featurecounts.txt \
  /data/courses/rnaseq/toxoplasma_de/AM_workplace/Maping/*.bam 