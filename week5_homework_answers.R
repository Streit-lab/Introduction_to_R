# bulk RNAseq differential expression analysis


# list count files from alignment
read.counts <- readRDS("~/dev/repos/R_training/test_data/test_DESeq2.RDS")

# You can see that whereas in previous sessions we had two columns, we now have three: gene IDs, gene annotations and sample
head(read.counts$untreated1)

# the aim is to create two dataframes from these data. First, we want a dataframe of the gene IDs and corresponding annotations. This is 
# so that we can identify the ENS_ID for a gene of interest later. The second will be a dataframe of our gene counts.



########################################################
#                     Task 1                           #
#        Creating an annotations dataframe             #
########################################################

# Here you need to create an annotations dataframe with gene names and gene IDs. Then you need to make sure the gene names are unique.

# As all of the samples were aligned together, they contain the same genes and gene annotations.

# This means that we can generate our annotation DF directly from the dataframe from the first sample. However given that we have NAs in our gene
# annotations, we need to edit this column so that if there is an NA present, we take the ensembl ID.
annotations <- read.counts[[1]][, c(1,2)]

# First - do this using a for loop
temp <- c()
for(i in 1:nrow(annotations)){
  if(is.na(annotations[i,2])){
    temp[i] <- annotations[i,1]
  }else{
    temp[i] <- annotations[i,2]
  }
}

# Second - do the same thing using apply
# APPLY WHAHAAAAA??? HOW DOES APPLY EVEN WORK?
# Glad you asked! Here is an example...

# here is a matrix
temp <- matrix(1:10, ncol=2)

# apply applies a function across a 2D object >> i.e. dataframes or matrices

# apply(DF, 1, function(x){someoperation}) will apply the function over the rows of a dataframe, whereas
# apply(DF, 2, function(x){someoperation}) will apply the function over the columns

apply(temp, 1, sum)
apply(temp, 1, function(x){sum(x)})

apply(temp, 2, sum)
apply(temp, 2, function(x){sum(x)})

# now go ahead! use apply and use ifelse() to keep the gene name if it present, otherwise gene ID

apply(annotations, 1, function(x){
  if(is.na(x[2])){
    x[1]
  }else{
    x[2]
  }
  
})

annotations[,2] <- apply(annotations, 1, function(x){ifelse(is.na(x[2]), x[1], x[2])})

# you could also do this using an index of which positions are na and then replacing those
annotations <- read.counts[[1]][, c(1,2)]
annotations[is.na(annotations$external_gene_id),2] <- annotations[is.na(annotations$external_gene_id),1]

# then make the gene annotations column unique!
annotations[,2] <- make.unique(annotations[,2])

########################################################
#                     Task 2                           #
#               Merge sample counts                    #
########################################################

# Generate a dataframe for the gene counts and ensembl IDs (use function from week 4 homework)
newfunction <- function(dataframes, by.col){
  newmerged.data <- dataframes[[1]]
  for (i in names(dataframes)[2:length(dataframes)]) {newmerged.data=merge(x=newmerged.data, y=dataframes[[i]], by=by.col)
  }
  return(newmerged.data)
}

merged.data <- newfunction(dataframes = read.counts, by.col = "ensembl_gene_id")

# As the dataframes have both gene IDs and gene annotation columns in there, we need to remove the unnecessary gene annotation columns
temp <- c("alex", "vida", "scarlet")
# %in% will return false if the match is not exact
temp %in% "al"

# instead you can use pattern matching with grep >> then remove the matching columns from the dataset
grep("al", temp)


merged.data <- merged.data[,-grep("external_gene", colnames(merged.data))]


# another option would be to remove the external gene columns before merging the samples

read.counts2 <- lapply(read.counts, function(x) x[,-2])
merged.data <- newfunction(dataframes = read.counts2, by.col = "ensembl_gene_id")
########################################################
#                     Task 3                           #
#     replace Gene.ID column with gene annotation      #
######################################################## 
# The final task is to replace the geneID column in the counts dataframe with the corresponding gene names in the annotations dataframe

merged.data <- merge(annotations, merged.data, by = "ensembl_gene_id")

# set gene names as rownames and delete extra naming columns from dataset
rownames(merged.data) <- merged.data[,2]
merged.data[,c(1,2)] <- NULL


