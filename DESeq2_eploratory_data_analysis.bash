#process file in ubuntu to delete 1st line + 
tail -n +2 featurecounts_proc.txt | cut -f 1,7-22 > featurecounts_proc.txt

#scp amechakra@binfservms01.unibe.ch:/data/courses/rnaseq/toxoplasma_de/AM_workplace/Reads_counting/featurecounts_proc.txt /mnt/c/Users/Amech/Desktop
#R script with DESeq2
cts <- as.matrix(read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\featurecounts_lung_samples.txt",sep="\t", row.names="ens_gene_id"))
coldata <- read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\sample_annotation.txt", sep="\t", row.names=1)
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

DESeq2::results(ddsvst, contrast = c("Sample"))

library("pheatmap")
select <- order(rowMeans(counts(ddsvst, normalized=FALSE)), decreasing=TRUE)[1:20]
df <- as.data.frame(colData(ddsvst)[,c("Sample","type")])
pheatmap(assay(ddsvst)[select,], cluster_rows = FALSE, cluster_cols = FALSE, annotation_col = df)