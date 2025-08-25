#!/bin/bash
#SBATCH -J bw
#SBATCH -p super
#SBATCH -N 1
#SBATCH -t 0-12:35:30
#SBATCH -o 5.bw_o%j.out
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

cd /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/BrowserTracks

##
#module load R/2.15.3-intel
#R --no-save --vanilla  < 6.makeRDataFiles_GenerateWigFiles_atacseq_allmerged.R


# convert wig to bigwig
#export PATH=/home2/anaga2/anusha_softwares/executables:$PATH
#export PATH=/home2/tnandu/softwares/executables:$PATH
export PATH=/project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0/BrowserTracks:$PATH

./wigToBigWig WT.sorted_strandSp.Forward.wig /project/GCRB/Lee_Lab/shared/CommonGenomes_Indexes/chromsizes/mm10.chrom.sizes -clip WT_Forward.bw
./wigToBigWig WT.sorted_strandSp.Reverse.wig /project/GCRB/Lee_Lab/shared/CommonGenomes_Indexes/chromsizes/mm10.chrom.sizes -clip WT_Reverse.bw

./wigToBigWig KI.sorted_strandSp.Forward.wig /project/GCRB/Lee_Lab/shared/CommonGenomes_Indexes/chromsizes/mm10.chrom.sizes -clip KI_Forward.bw
./wigToBigWig KI.sorted_strandSp.Reverse.wig /project/GCRB/Lee_Lab/shared/CommonGenomes_Indexes/chromsizes/mm10.chrom.sizes -clip KI_Reverse.bw


