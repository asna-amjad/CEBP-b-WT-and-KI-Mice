#!/bin/bash
#SBATCH -J strainMerge
#SBATCH -p super
#SBATCH -N 1
#SBATCH -t 1-20:35:30
#SBATCH --output=strainMerge_%j.out
#SBATCH --error=strainMerge_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


cd /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/call-transcripts-cufflinks.sh-1.0.0


## WT + KI
./merge-transcripts-cufflinks.sh -o merge_transcripts_WT -r /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa -a /project/GCRB/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf -g 1924_S23_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam.transcripts.gtf 1925_S24_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam.transcripts.gtf 1926_S25_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam.transcripts.gtf 1931_S26_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam.transcripts.gtf 1932_S27_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam.transcripts.gtf 1970_S28_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam.transcripts.gtf

