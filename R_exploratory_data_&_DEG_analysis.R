cts <- as.matrix(read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\featurecounts_proc3.txt",sep="\t", row.names="ens_gene_id"))
coldata <- read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\sample_annotation2.txt", sep="\t", row.names=1)
coldata <- coldata[,c("Sample", "type")]
coldata$Sample <- factor(coldata$Sample)
coldata$type <- factor(coldata$type)
all(rownames(coldata) %in% colnames(cts))
all(rownames(coldata) == colnames(cts))

library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ Sample)
dds

ddsvst <- vst(dds, blind=TRUE)
DESeq2::plotPCA(ddsvst, intgroup = "Sample")
dds <- DESeq(dds)
lung_result<- results(dds, contrast=c("Sample", "Lung_WT_Case","Lung_WT_Control"))

sig_lres <- lung_result[!is.na(lung_result$padj) & lung_result$padj < 0.05 & abs(lung_result$log2FoldChange)>1,]
write.csv(sig_lres, file="sig_lres.csv")

up<- subset(sig_lres, log2FoldChange > 0)
up#2005
head(up)
write.csv(up, file="up.csv")
down<- subset(sig_lres, log2FoldChange < 0)
down#2962
write.csv(sig_lres, file="down.csv")

blood_results<- results(dds, contrast=c("Sample", "Blood_WT_Case","Blood_WT_Control"))
sig_bresl <- blood_results[!is.na(blood_results$padj) & blood_results$padj < 0.05 & abs(blood_results$log2FoldChange)>1,]
write.csv(sig_bresl, file="DEG_blood.csv")
blood_up<- subset(sig_bresl, log2FoldChange > 0)
head(blood_up)
write.csv(blood_up, file="blood_up.csv")
blood_down<- subset(sig_bresl, log2FoldChange < 0)
head(blood_down)
write.csv(blood_down, file="blood_down.csv")

gene1 <- "ENSMUSG00000000386"
gene2 <- "ENSMUSG00000041515"
gene3 <- "ENSMUSG00000020826"
plotCounts(dds, gene="ENSMUSG00000000386", intgroup = "Sample")
plotCounts(dds, gene="ENSMUSG00000041515", intgroup = "Sample")
plotCounts(dds, gene="ENSMUSG00000020826", intgroup = "Sample")

