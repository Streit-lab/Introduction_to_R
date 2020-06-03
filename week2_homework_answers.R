# here are two samples from a fake RNAseq dataset
testdata <- readRDS("./test_data/fakeRNAseq_week2.RDS")

# for this example I have replaced gene names with ensembl IDs to keep them unique
# the data is stored as a list of dataframes
# REMEMBER - individual elements of a LIST can be accessed using the double brackets data[[1]]

# task 1: check whether ALL of the ensembl IDs in the first dataframe are present in the second
all(testdata$SOX8_1[,"geneID"] %in% testdata$SOX8_2[,"geneID"])

# task 2: 'intersect' the two dataframes to see which ensembl IDs are shared
intersect(testdata$SOX8_1[,"geneID"], testdata$SOX8_2[,"geneID"])

# task 3: use the vector of shared genes to subset both dataframes
sharedgenes <- intersect(testdata$SOX8_1[,"geneID"], testdata$SOX8_2[,"geneID"])
sub1 <- testdata$SOX8_1[testdata$SOX8_1[,'geneID'] %in% sharedgenes, ]
sub2 <- testdata$SOX8_2[testdata$SOX8_2[,'geneID'] %in% sharedgenes, ]

# task 4: use the 'match' function to re-order the second dataframe, based on the order of geneIDs in the first
# when using match, you need to subset using the second argument in the match statement
sam1 <- c("a", "b", "c", "d")
sam2 <- c("a", "d", "b", "c")
sam2[match(sam1, sam2)]

sub2.ordered <- sub2[match(sub1$geneID, sub2$geneID),]

# task 5: now that your dataframes are in the same order combine the two dataframes into one
joined.data <- cbind(sub1, sub2.ordered$counts)

# you can use merge to combine dataframes based on a defined column -> much mroe straight forward
merge(x = sub1, y = sub2, by = "geneID")




