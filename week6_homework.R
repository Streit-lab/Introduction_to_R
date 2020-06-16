
# Task1.
# Run deseq pipeline
# intalll deseq2 and dependencies if not already installed
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")
BiocManager::install("apeglm")

library(DESeq2)

# DESeq2 vignette can be found here
vignette("DESeq2")

# You can find the basic steps under quickstart


# Task 2.
# Once you have obtained a list of DE genes, filter only genes which pass a FC and padj(FDR) threshold


# Task3.
# Subset the counts assay using these genes are plot a heatmap of the differentially expressed genes using pheatmap
install.packages("pheatmap")
library(pheatmap)







