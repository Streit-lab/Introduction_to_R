
# here are two samples from a fake RNAseq dataset
testdata <- readRDS("./test_data/fakeRNAseq_week2.RDS")

# Following on from last weeks homework, we now have a merged dataframe with the gene counts for 7 samples.

# This week's task is to repeat the same procedure BUT instead of manually doing this, this time you need to make
# your own custom function capable of combining n samples.

# This function should include at least the following arguments -> function(dataframes, sample.names, by.col, counts.col), where:
#         dataframes = list of dataframes to be merged
#         by.col = name of column you want to merge the dataframes by
#         counts.col = name of the counts column which are to be renamed by the sample.names

# Good luck!


