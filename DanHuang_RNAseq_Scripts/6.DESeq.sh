#!/bin/bash
#SBATCH -J fcounts                                               # job name
#SBATCH -p super                                                         # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH -N 2                                                             # number of nodes requested by user
#SBATCH -t 1-4:35:30                                                     # run time, format: D-H:M:S (max wallclock time) 
#SBATCH --output=fcounts_%j.out
#SBATCH --error=fcounts_%j.err                             # standard output file name
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu                # specify an email address
#SBATCH --mail-type=BEGIN                                                # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=END                                          # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=FAIL                                         # send email when job status change (start, end, abortion and etc.)

module load subread/1.6.3
cd /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0

mkdir Deseq-outs

########################################################################
######## filenames
FILE1='1924_S23_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam'
FILE2='1925_S24_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam'
FILE3='1926_S25_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam'
FILE4='1931_S26_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam'
FILE5='1932_S27_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam'
FILE6='1970_S28_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam'


featureCounts -a gencode.vm25.annotation.gtf  -t exon -T 16 -o Deseq-outs/counts_Rseq.txt -s 2 -M --fraction $FILE1 $FILE2 $FILE3 $FILE4 $FILE5 $FILE6
