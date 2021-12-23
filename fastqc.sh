#!/bin/bash

#SBATCH --job-name="doQC"
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=2GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=am21t030@campus.unibe.ch
# download module in https://www.vital-it.ch/services
module add UHTS/Quality_control/fastqc/0.11.9;
# link to fsdtq files contained in "READS" folder
ln -s /data/courses/rnaseq/toxoplasma_de/reads/*.fastq.gz .
# Run fastqc 
fastqc -t 4 *.fastq.gz

#execute the script (sbatch fastqc.sh)

#download and view results in local machine

#scp amechakra@binfservms01.unibe.ch:/data/courses/rnaseq/toxoplasma_de/AM_workplace/Quality_checks/*.html /mnt/c/Users/Amech/Desktop

#trimmimg with trimmomatic to remove bad quality reads
#load package
#module add UHTS/Analysis/trimmomatic/0.36;
#run multiQC in the shell
#srun  --mem=25G --cpus-per-task=2 --time=01:00:00 --pty bash
#multiqc .
#copy html report
#scp amechakra@binfservms01.unibe.ch:/data/courses/rnaseq/toxoplasma_de/AM_workplace/Quality_checks/multiqc_report.html /mnt/c/Users/Amech/Desktop

#produce stats for the fastq files with seqkit stat module
#allocate ressources 
#srun  --mem=25G --cpus-per-task=2 --time=01:00:00 --pty bash
#add module : module add UHTS/Analysis/SeqKit/0.13.2
#run seqkit stat *.gz > fastq_stats.txt
#copy locally 
