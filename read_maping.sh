#!/bin/sh
#SBATCH --job-name="maping"
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --nodes=7
#SBATCH --mem=8GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=am21t030@campus.unibe.ch
#SBATCH --array=0-15%7

sample_names=("SRR7821921" "SRR7821922" "SRR7821918" "SRR7821919" "SRR7821920" "SRR7821937" "SRR7821938" "SRR7821939" "SRR7821949" "SRR7821950" "SRR7821951" "SRR7821952" "SRR7821953" "SRR7821968" "SRR7821969" "SRR7821970")

module add UHTS/Aligner/hisat/2.2.1;
module add UHTS/Analysis/samtools/1.10

data_dir=/data/courses/rnaseq/toxoplasma_de/AM_workplace/Quality_checks

#hisat2 -x mg_indexed -1 $data_dir/${sample_names[$SLURM_ARRAY_TASK_ID]}_1.fastq.gz -2 $data_dir/${sample_names[$SLURM_ARRAY_TASK_ID]}_2.fastq.gz -S ./${sample_names[$SLURM_ARRAY_TASK_ID]}.sam -p 4 --rna-strandness RF

#convert to bam with samtools
samtools view -@ 4 -bo ./${sample_names[$SLURM_ARRAY_TASK_ID]}_unsorted.bam ./${sample_names[$SLURM_ARRAY_TASK_ID]}.sam 

samtools sort -@ 4 -o ./${sample_names[$SLURM_ARRAY_TASK_ID]}.bam ./${sample_names[$SLURM_ARRAY_TASK_ID]}_unsorted.bam
rm ./${sample_names[$SLURM_ARRAY_TASK_ID]}_unsorted.bam

samtools index ${sample_names[$SLURM_ARRAY_TASK_ID]}.bam
