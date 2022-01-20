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
df = read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\Section6\\sig_lres.csv", header=TRUE)
df2 <- read.csv("C:\\Users\\Amech\\Desktop\\RNAseq_analysis\\featurecounts_lung_samples.csv", header=TRUE)

# we want the log2 fold change 
original_gene_list <- df$ens_gene_id

# name the vector
names(original_gene_list) <- df$X

# omit any NA values 
gene_list<-na.omit(original_gene_list)

# sort the list in decreasing order (required for clusterProfiler)
gene_list = sort(gene_list, decreasing = TRUE)
#Gene Set Enrichment
keytypes(org.Mm.eg.db)

gse <- gseGO(gene=gene_list,
             universe =df2,
             ont ="BP", 
             keyType = "ENSEMBL",
             OrgDb = org.Mm.eg.db)
#Output
require(DOSE)
dotplot(gse, showCategory=10, split=".sign") + facet_grid(.~.sign)
data(gse)

library(DOSE)


barplot(gse, showCategory=20) 

