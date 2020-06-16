
# here are two samples from a fake RNAseq dataset
testdata <- readRDS("./test_data/fakeRNAseq_week2.RDS")

# Following on from last weeks homework, we now have a merged dataframe with the gene counts for 7 samples.
for (i in names(testdata)) {
  colnames(testdata[[i]])[colnames(testdata[[i]]) == "counts"] <- paste0('counts',i)
  print(colnames(testdata[[i]]))
}
Merged.data<- testdata[[1]]
for (i in names(testdata)[2:7]) {
  Merged.data=merge(x=Merged.data, y=testdata[[i]], by='geneID')  
  
}

# This week's task is to repeat the same procedure BUT instead of manually doing this, this time you need to make
# your own custom function capable of combining n samples.

# This function should include at least the following arguments -> function(dataframes, sample.names, by.col, counts.col), where:
#         dataframes = list of dataframes to be merged
#         sample.names = vector of sample names in order to rename the counts column. This is so the samples can be identified in the final dataframe
#         by.col = name of column you want to merge the dataframes by
#         counts.col = name of the counts column which are to be renamed by the sample.names

# Good luck!

testdata <- readRDS("./test_data/fakeRNAseq_week2.RDS")

# assign function
newfunction <- function(dataframes, by.col, counts.col){
  sample.names<- names(dataframes)
  for (i in sample.names) { 
    colnames(dataframes[[i]])[colnames(dataframes[[i]])==counts.col] <- paste0('counts_',i)
  }
  newmerged.data <- dataframes[[1]]
  for (i in sample.names[2:length(dataframes)]) {newmerged.data=merge(x=newmerged.data, y=dataframes[[i]], by=by.col)
  
  }
  return(newmerged.data)
}

# test function
newfunction(dataframes = testdata, by.col = 'geneID', counts.col = 'counts')

# if function isnt working you can use debug in order to see which parts arent working
debug(newfunction)
newfunction(dataframes = testdata, by.col = 'geneID', counts.col = 'counts')
undebug(newfunction)



# you can add extra functionality to a function by adding an extra argument and assigniing defaults which you want the user to be able to change if they like
newfunction <- function(dataframes, sample.names = names(dataframes), by.col, counts.col){
  for (i in 1:length(dataframes)) {
    colnames(dataframes[[i]])[colnames(dataframes[[i]])==counts.col] <- paste0('counts_', sample.names[i])
  }
  newmerged.data <- dataframes[[1]]
  for (i in names(dataframes)[2:length(dataframes)]) {newmerged.data=merge(x=newmerged.data, y=dataframes[[i]], by=by.col)
  
  }
  return(newmerged.data)
}

# you can see in the output that the sample names by default will be assigned as the names of the dataframes in the list.
# however this can be overriden by providing a vector of names to the sample.names argument
newfunction(dataframes = testdata, by.col = 'geneID', counts.col = 'counts')
newfunction(dataframes = testdata, sample.names = c("a", "b", "c", "d", "e", "f", "g"), by.col = 'geneID', counts.col = 'counts')


