#!/bin/bash
#SBATCH --job-name=RNA_staralign                              # job name
#SBATCH --partition=super                                 # pelect partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH --mem 123904
#SBATCH --nodes=1                                         # number of nodes requested by uper
#SBATCH --time=1-11:00:00                                 # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=2.align_%j.out                         # standard output file name
#SBATCH --error=2.align_%j.err                         # standard error output file name
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu           # specify an email address
#SBATCH --mail-type=FAIL,END  


#export PATH=/work/GCRB/s210012/Scripts/RNA_Pipeline/rna-seq-pipeline:$PATH 

cd /project/aamajd/RNAseq_April2025

fastqs='1924_S23_R1_001 1925_S24_R1_001 1926_S25_R1_001 1931_S26_R1_001 1932_S27_R1_001 1970_S28_R1_001'

#########running for the fastqs
for fastq in $fastqs
do
echo $fastq
echo ${fastq}.fastq.gz
pwd
#For MM10
./align-star-se.sh -f ${fastq}.fastq.gz -i /project/shared/Star_Indexes_2.7.2b/GRCm38_refseq/STAR_Index -a /project/shared/Star_Indexes_2.7.2b/GRCm38_refseq/gencode.vM25.annotation.gtf -o /project/shared/Dan/RNAseq_April2025/Align/
done


