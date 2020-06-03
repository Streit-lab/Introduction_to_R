
# here are two samples from a fake RNAseq dataset
testdata <- readRDS("./fakeRNAseq_week2.RDS")

# The task this week is to combine the 7 dataframes from testdata into a single dataframe

# You need to make sure that you only keep the genes which are present in all of the samples,
# that all of the samples are ordered in the same, that the samples are renamed, and then combined 
# into a single dataframe

# 1) combine the dataframes using merge() - i.e. the easy way!

# 2) combine using cbind() - this means you need to manually change the row order and subset shared rows

# Good luck!







