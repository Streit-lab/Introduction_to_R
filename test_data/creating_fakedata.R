temp <- readRDS("test_data/fake_bulkdata.RDS")


# get random ensembl names
geneid <- read.table("~/dev/data/Sox8/alignment_output/WTCHG_706842_201108_1Aligned.sortedByCoord.out_gene.featureCounts.txt", header = T)
geneid <- geneid$Geneid

# reorder samples so they are the same order
temp <- lapply(temp, function(x){
  df <- x[order(as.numeric(rownames(x))),]
  df["geneID"] <- geneid[1:nrow(df)]
  return(df[, c("geneID", "counts")])
  }
)

# randomly re-order rows in each dataframe
temp <- lapply(temp, function(x){
  x[sample(nrow(x)),]
})

# remove random genes from each sample - use *-1 to convert to negative
temp <- lapply(temp, function(x){
  x[sample(nrow(x), size = 500)*-1,]
})

# remove rownames from samples
temp <- lapply(temp, function(x){
  rownames(x) <- NULL
  return(x)
})


saveRDS(temp, "./test_data/fakeRNAseq_week2.RDS")


