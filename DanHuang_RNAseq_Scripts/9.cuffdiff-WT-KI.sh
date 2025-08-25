#!/bin/bash
#SBATCH -J CuffDiff
#SBATCH -p super
#SBATCH -N 1
#SBATCH -t 1-20:35:30
#SBATCH --output=CuffDiff_%j.out
#SBATCH --error=CuffDiff_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


cd /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0

./compare-expression-cufflinks.sh -o 'WTvsKI' -e 'WT,KI' -a '1924_S23_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam,1925_S24_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam,1926_S25_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam 1931_S26_R1_001.fastq.gz.Aligned.sortedByCoord.out.bam,1932_S27_R1_001.fastq.gz.Aligned.sortedByCoord.out.bam,1970_S28_R1_001.fastq.gz.Aligned.sortedByCoord.out.bam' -r '/project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa' -g 'merged.gtf'

