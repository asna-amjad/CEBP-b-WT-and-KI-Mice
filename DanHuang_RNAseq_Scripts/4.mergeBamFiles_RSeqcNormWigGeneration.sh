#!/bin/bash
#SBATCH -J wig	                                                 # job name
#SBATCH -p super                                                         # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH -N 1                                                             # number of nodes requested by user
#SBATCH -t 0-20:35:30                                                    # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=wig_%j.out
#SBATCH --error=wig_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu               # specify an email address
#SBATCH --mail-type=BEGIN                                                # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=END                                          # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=FAIL                                         # send email when job status change (start, end, abortion and etc.)



##### Remove sequencerID to reduce file size from the bed files
cd /project/aamjad/RNAseq_April2025/Align/align-star-se.sh-1.0.0

module load python/2.7.x-anaconda
module load bedtools/2.25.0
module load samtools/intel/1.3
module add RSeQC/2.6.4

export PATH=/home/softwares/executables:$PATH

function MakeSignalTracks
{
##Sort replicates:
##samtools sort $FILENAME1.bam -o $FILENAME1.sorted.bam
##samtools sort $FILENAME2.bam -o $FILENAME2.sorted.bam
##samtools sort $FILENAME3.bam -o $FILENAME3.sorted.bam


##Merge replicates, sort & index:
##samtools merge $FILENAME5.bam $FILENAME1.sorted.bam $FILENAME2.sorted.bam $FILENAME3.sorted.bam
##samtools sort $FILENAME5.bam -o $FILENAME5.sorted.bam
##samtools index $FILENAME5.sorted.bam


##Check the library type:
##infer_experiment.py -r  GRCm38_mm10_RefSeq.bed -i $FILENAME5.sorted.bam 
#Can run this separately to understand "+-,-+" trend of the file

##Convert bam to wig:
bam2wig.py -s mm10.chrom.sizes -i SignalTracks/$FILENAME5.sorted.bam -o BrowserTracks/$FILENAME5.sorted_strandSp -u -t 2977321000 -d "+-,-+"
##      Specified wigsum. 100000000 equals to coverage of 1 million 100nt reads. Ignore this option to disable normalization; In this case, read length is 100, average lib size is 100*29773210 = 2977321000
}



FILENAME1="1924_S23_R1_001.fastq.gz.Aligned.sortedByCoord.out"
FILENAME2="1925_S24_R1_001.fastq.gz.Aligned.sortedByCoord.out"
FILENAME3="1926_S25_R1_001.fastq.gz.Aligned.sortedByCoord.out"
FILENAME5="WT"
MakeSignalTracks

FILENAME1="1931_S26_R1_001.fastq.gz.Aligned.sortedByCoord.out"
FILENAME2="1932_S27_R1_001.fastq.gz.Aligned.sortedByCoord.out"
FILENAME3="1970_S28_R1_001.fastq.gz.Aligned.sortedByCoord.out"
FILENAME5="KI"
MakeSignalTracks


