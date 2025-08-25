#!/bin/bash
#SBATCH -J corr			                                           # job name
#SBATCH -p super                                                         # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH -N 2                                                             # number of nodes requested by user
#SBATCH -t 1-12:35:30                                                    # run time, format: D-H:M:S (max wallclock time)
#SBATCH --error=3.corr_%j.err
#SBATCH --output=3.corr_%j.out                                                    # standard output file name
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu               # specify an email address
#SBATCH --mail-type=BEGIN                                                # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=END                                          # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=FAIL                                         # send email when job status change (start, end, abortion and etc.)

module load deeptools/3.5.0

cd /project/GCRB/Lee_Lab/shared/Dan/RNAseq_April2025/Align/align-star-se.sh-1.0.0
mkdir correlations
#export PATH=/home2/tnandu/rna-seq-pipeline/:$PATH
function correlations {
multiBamSummary bins --bamfiles ${File1}.fastq.gz.Aligned.sortedByCoord.out.bam ${File2}.fastq.gz.Aligned.sortedByCoord.out.bam ${File3}.fastq.gz.Aligned.sortedByCoord.out.bam -o correlations/$NAME.npz
plotCorrelation -in correlations/$NAME.npz --corMethod pearson --skipZeros --plotTitle "Pearson Correlation Scatterplot" --whatToPlot heatmap --plotNumbers -o correlations/$NAME.heatmap.png
plotCorrelation -in correlations/$NAME.npz --corMethod pearson --skipZeros --plotTitle "Pearson Correlation HeatMapplot" --whatToPlot scatterplot -o correlations/$NAME.scatterplot.png --outFileCorMatrix correlations/$NAME_PearsonCorr.tab
}


##############################################################
### Samples
##############################################################

#1. WT
File1="1924_S23_R1_001"
File2="1925_S24_R1_001"
File3="1926_S25_R1_001"
NAME="WT"
correlations

#2. KI
File1="1931_S26_R1_001"
File2="1932_S27_R1_001"
File3="1970_S28_R1_001"
NAME="KI"
correlations



