library(ggplot2)

results_tgf <- read.table("KIvsWT_DEGs_FC2_gene_symbols_final.txt", header = T, sep = "\t")
results_tgf %>% 
  ggplot(aes(x = log2FoldChange, y = -log10(padj))) + geom_point()


results_tgf %>% 
  mutate(Significant = padj < 0.05 & abs(log2FoldChange) > 2) %>% 
  ggplot(aes(x = log2FoldChange, y = -log10(padj), col=Significant)) + geom_point()

res.df <- as.data.frame(results_tgf)
EnhancedVolcano(res.df, x = "log2FoldChange", y = "padj", lab = res.df$Symbol)

#, pCutoff = 1e-4, FCcutoff = 1

results_tgf %>% 
  mutate(Significant = abs(log2FoldChange) > 2) %>% 
  ggplot(aes(x = log2FoldChange, y = -log10(pvalue), col=Significant)) + geom_point()

keyvals.colour <- ifelse(
  res$log2FoldChange < -2, 'royalblue',
  ifelse(res$log2FoldChange > 2, 'gold',
         'black'))
keyvals.colour[is.na(keyvals.colour)] <- 'black'
names(keyvals.colour)[keyvals.colour == 'gold'] <- 'high'
names(keyvals.colour)[keyvals.colour == 'black'] <- 'mid'
names(keyvals.colour)[keyvals.colour == 'royalblue'] <- 'low'

res.df <- as.data.frame(results_tgf)
EnhancedVolcano(res.df, x = "log2FoldChange", y = "pvalue", lab = res.df$Symbol, title = 'WT versus KI', col=c('grey', 'black', 'black', 'red3'))

##################

keyvals <- 
  ifelse(res.df$log2FoldChange < -1 & res.df$padj < 0.05, 'royalblue',
         ifelse(res.df$log2FoldChange > 1 & res.df$padj < 0.05, 'red2',
                'grey30'))

keyvals[is.na(keyvals)] <- 'grey30'
names(keyvals)[keyvals == 'red2'] <- 'upregulated'
names(keyvals)[keyvals == 'grey30'] <- 'not significant'
names(keyvals)[keyvals == 'royalblue'] <- 'downregulated'

EnhancedVolcano(res.df,
                x = 'log2FoldChange',
                y = 'padj',
                lab = res.df$Symbol,
                
                title = 'WT vs. KI',
                pCutoff = 0.05,
                FCcutoff = 1,
                cutoffLineWidth = 0.8,
                pointSize = 2.0,
                labSize = 4.0,
                widthConnectors = 0.5,
                colCustom = keyvals,
                xlim = c(-5, 10),
                ylim = c(-5, 40))

####################

keyvals <- 
  ifelse(res.df$log2FoldChange < -1 & res.df$pvalue < 0.05, 'blue',
         ifelse(res.df$log2FoldChange > 1 & res.df$pvalue < 0.05, 'red2',
                'grey30'))

keyvals[is.na(keyvals)] <- 'grey30'
names(keyvals)[keyvals == 'red2'] <- 'upregulated'
names(keyvals)[keyvals == 'grey30'] <- 'not significant'
names(keyvals)[keyvals == 'blue'] <- 'downregulated'

EnhancedVolcano(res.df,
                x = 'log2FoldChange',
                y = 'pvalue',
                lab = res.df$Symbol,
                
                title = 'WT vs. KI',
                pCutoff = 0.05,
                FCcutoff = 1,
                cutoffLineWidth = 0.8,
                pointSize = 2.0,
                labSize = 4.0,
                widthConnectors = 0.5,
                colCustom = keyvals,
                xlim = c(-5, 10),
                ylim = c(-5, 45))
