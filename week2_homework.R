# here are two samples from a fake RNAseq dataset
testdata <- readRDS("./test_data/fakeRNAseq_week2.RDS")

# for this example I have replaced gene names with ensembl IDs to keep them unique
# the data is stored as a list of dataframes
# REMEMBER - individual elements of a LIST can be accessed using the double brackets data[[1]]

# task 1: check whether ALL of the ensembl IDs in the first dataframe are present in the second

# task 2: 'intersect' the two dataframes to see which ensembl IDs are shared

# task 3: use the vector of shared genes to subset both dataframes

# task 4: use the 'match' function to re-order the second dataframe, based on the order of geneIDs in the first

# task 5: now that your dataframes are in the same order combine the two dataframes into one



