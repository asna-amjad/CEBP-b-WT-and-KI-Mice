library(DESeq2)
library(ggpubr)
library(gplots)

setwd("/Users/Desktop/Cebp_RNAseq/Deseq-outs/")

data <- read.table("counts_Rseq.txt",sep="\t",header = TRUE)
colnames(data) <- c("Geneid","Chr","Start","End","Strand","Length","WT_REP1","WT_REP2","WT_REP3","KI_REP1","KI_REP2","KI_REP3")

a<-subset(data,select=`WT_REP1`:`KI_REP3`)
cts<-as.matrix(a)	# count matrix
cts<-round(cts,0)
row.names(cts)<-data$Geneid
coldata<-read.csv("WT_KI_conditions.txt",sep="\t",header=T,row.names=1)
condition <- factor(coldata$condition, levels=c("WT","KI"))

dds <- DESeqDataSetFromMatrix(countData=cts, colData=coldata, design=~condition)
keep <- rowSums(counts(dds)) >= 10 # only keeping rows with fold changes more than or equal to 10
dds <- dds[keep,]
dds_norm_estimatesize <- estimateSizeFactors(dds)
deseq_Ncounts <- as.data.frame(counts(dds_norm_estimatesize, normalized=TRUE))
write.table(deseq_Ncounts, "DH_counts_rnaseq_all_samples_normalizedcounts.txt",sep="\t",quote=F)

dds <- DESeq(dds)
rld <- rlogTransformation(dds)
resultsNames(dds)

library(ggplot2)
vsdata <- vst(dds, blind=FALSE)
pdf("DH_RNAseqplot.pdf")
plotPCA(vsdata) + geom_text(size=2,aes(label=name),vjust=2) +
  scale_y_continuous(limits = c(-14,8))
dev.off()

normlzd_dds <- counts(dds_norm_estimatesize, normalized=TRUE)
pdf("DH_RNAseq_DEG_hclust.pdf")
plot(hclust(dist(t(normlzd_dds))), labels=colData(dds)$protocol)
dev.off()

################### WT vs. KI ######################
res<- results(dds, contrast=c("condition","KI","WT"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="1.KIvsWT_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("1.KIvsWT_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) # 2578
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) # 1617
up$RegStatus <- paste("UP_in_KI")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) # 896
down$RegStatus <- paste("DOWN_in_KI")

DEG_1 <- rbind(up,down)
NROW(DEG_1) # 2513
write.table(DEG_1, file="KIvsWT_DEGs.txt",sep="\t",quote=F,row.names=T)

#############################################################################
################### WT vs. KI (WT 3 REPS & KI 2 REPS ) ######################

data <- read.table("counts_Rseq.txt",sep="\t",header = TRUE)
colnames(data) <- c("Geneid","Chr","Start","End","Strand","Length","WT_REP1","WT_REP2","WT_REP3","KI_REP1","KI_REP2","KI_REP3")

a<-subset(data,select=`WT_REP1`:`KI_REP2`)
cts<-as.matrix(a)	# count matrix
cts<-round(cts,0)
row.names(cts)<-data$Geneid
coldata<-read.csv("WT_KI-2Reps_conditions.txt",sep="\t",header=T,row.names=1)
condition <- factor(coldata$condition, levels=c("WT","KI"))

dds <- DESeqDataSetFromMatrix(countData=cts, colData=coldata, design=~condition)
keep <- rowSums(counts(dds)) >= 10 # only keeping rows with fold changes more than or equal to 10
dds <- dds[keep,]
dds_norm_estimatesize <- estimateSizeFactors(dds)
deseq_Ncounts <- as.data.frame(counts(dds_norm_estimatesize, normalized=TRUE))
write.table(deseq_Ncounts, "DH_counts_rnaseq_all_samples_normalizedcounts_KI-2REPS.txt",sep="\t",quote=F)

dds <- DESeq(dds)
rld <- rlogTransformation(dds)
resultsNames(dds)

library(ggplot2)
vsdata <- vst(dds, blind=FALSE)
pdf("DH_RNAseqplot_KI-2REPSnew.pdf")
plotPCA(vsdata) + geom_text(size=2,aes(label=name),vjust=2) + 
scale_y_continuous(limits = c(-10,10))
dev.off()


################### WT vs. KI (WT 3 REPS & KI 2 REPS ) ######################

res<- results(dds, contrast=c("condition","KI","WT"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="1.KIvsWT_DESEQ2_KI-2REPS.txt",sep="\t",quote=F,row.names=T)

## Log2 Fold Change 0.58 (FC 1.5)
#################################
resdata <- read.table("1.KIvsWT_DESEQ2_KI-2REPS.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) # 7186
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) # 3581
up$RegStatus <- paste("UP_in_KI")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) # 3076
down$RegStatus <- paste("DOWN_in_KI")

DEG_2 <- rbind(up,down)
NROW(DEG_2) # 6657
write.table(DEG_2, file="KIvsWT_DEGs_KI-2REPS.txt",sep="\t",quote=F,row.names=T)

## Log2 Fold Change 1 (FC 2)
#############################
resdata <- read.table("1.KIvsWT_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) # 2578
up <- subset(resultsAlpha, log2FoldChange>=1 )
NROW(up) # 1302
up$RegStatus <- paste("UP_in_KI")

down <- subset(resultsAlpha, log2FoldChange <= -1)
NROW(down) # 195
down$RegStatus <- paste("DOWN_in_KI")

DEG_3 <- rbind(up,down)
NROW(DEG_3) # 1497
write.table(DEG_3, file="KIvsWT_DEGs_FC2.txt",sep="\t",quote=F,row.names=T)

## Log2 Fold Change 1 (FC 2) - KI 2 REPS
########################################
resdata <- read.table("1.KIvsWT_DESEQ2_KI-2REPS.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) # 7186
up <- subset(resultsAlpha, log2FoldChange>=1 )
NROW(up) # 2647
up$RegStatus <- paste("UP_in_KI")

down <- subset(resultsAlpha, log2FoldChange <= -1)
NROW(down) # 1248
down$RegStatus <- paste("DOWN_in_KI")

DEG_4 <- rbind(up,down)
NROW(DEG_4) # 3895
write.table(DEG_4, file="KIvsWT_DEGs_KI_2REPS_FC2.txt",sep="\t",quote=F,row.names=T)




