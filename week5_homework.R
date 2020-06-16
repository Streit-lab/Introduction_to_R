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

# First - do this using a for loop


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


# then make the gene annotations column unique!


########################################################
#                     Task 2                           #
#               Merge sample counts                    #
########################################################

# Generate a dataframe for the gene counts and ensembl IDs (use function from week 4 homework)

# As the dataframes have both gene IDs and gene annotation columns in there, we need to remove the unnecessary gene annotation columns

temp <- c("alex", "vida", "scarlet")
# %in% will return false if the match is not exact
temp %in% "al"

# instead you can use pattern matching with grep >> then remove the matching columns from the dataset
grep("al", temp)



########################################################
#                     Task 3                           #
#     replace Gene.ID column with gene annotation      #
######################################################## 
# The final task is to replace the geneID column in the counts dataframe with the corresponding gene names in the annotations dataframe

