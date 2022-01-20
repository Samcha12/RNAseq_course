if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("clusterProfiler")


BiocManager::install("clusterProfiler", version = "3.14")
BiocManager::install("pathview")
BiocManager::install("enrichplot")
library(clusterProfiler)
library(enrichplot)

# SET THE DESIRED ORGANISM HERE
organism = "org.Mm.eg.db"
BiocManager::install(organism, character.only = TRUE)
library(organism, character.only = TRUE)

# reading in data from deseq2
df = read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\Section6\\DEG_blood.csv", header=TRUE)
df2 <- read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\featurecounts_lung_samples.csv", header=TRUE)

# we want the log2 fold change 
original_gene_list <- df$log2FoldChange

# name the vector
names(original_gene_list) <- df$X

# omit any NA values 
gene_list<-na.omit(original_gene_list)

# sort the list in decreasing order (required for clusterProfiler)
gene_list = sort(gene_list, decreasing = TRUE)
#Gene Set Enrichment
keytypes(org.Mm.eg.db)

gse <- gseGO(geneList=gene_list,
             universe = df2$ens_gene_id,
             ont ="BP", 
             keyType = "ENSEMBL", 
             nPerm = 10000, 
             minGSSize = 3, 
             maxGSSize = 800, 
             pvalueCutoff = 0.05, 
             verbose = TRUE, 
             OrgDb = org.Mm.eg.db, 
             pAdjustMethod = "none")
#Output
require(DOSE)
dotplot(gse, showCategory=10, split=".sign") + facet_grid(.~.sign)




