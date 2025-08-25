#!/bin/bash
#SBATCH --job-name=fastqc                              # job name
#SBATCH --partition=super                                 # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH --nodes=1                                         # number of nodes requested by user
#SBATCH --time=0-48:00:00                                 # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=fastqc.%j.out                         # standard output file name
#SBATCH --error=fastqc.%j.time                         # standard error output file name
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu           # specify an email address
#SBATCH --mail-type=ALL                                   # send email when job status change (start, end, abortion and etc.)

module load fastqc
cd /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025
fastqc *.fastq.gz
