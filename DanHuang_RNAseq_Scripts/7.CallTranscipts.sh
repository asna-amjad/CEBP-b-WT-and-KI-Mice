#!/bin/bash
#SBATCH --job-name=calltranscripts
#SBATCH --partition=super 
#SBATCH --nodes=1 
#SBATCH --time=0-48:00:00
#SBATCH --output=calltranscripts_%j.out
#SBATCH --error=calltranscripts_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=ALL

cd /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0

### WT
./call-transcripts-cufflinks.sh -f /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/1924_S23_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam -g /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa -a /project/GCRB/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf
./call-transcripts-cufflinks.sh -f /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/1925_S24_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam -g /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa -a /project/GCRB/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf
./call-transcripts-cufflinks.sh -f /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/1926_S25_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam -g /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa -a /project/GCRB/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf

### KI
./call-transcripts-cufflinks.sh -f /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/1931_S26_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam -g /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa -a /project/GCRB/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf
./call-transcripts-cufflinks.sh -f /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/1932_S27_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam -g /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa -a /project/GCRB/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf
./call-transcripts-cufflinks.sh -f /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/1970_S28_R1_001.fastq.gz.Aligned.sortedByCoord.out.sorted.bam -g /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.fa -a /project/GCRB/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf

