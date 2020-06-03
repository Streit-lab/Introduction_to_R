#### Week 3
  
##### Today we will work on how to use for loops to combine multiple RNAseq samples together

###### Code to generate test data 1
temp <- c()
for(i in c("A", "B", "C", "D", "E")){
  temp <- append(temp, paste0(i, 1:5))
}

# Generate random gene counts
test.data1 <- list()
for(i in c("s1", "s2", "s3", "s4", "s5")){
  test.data1[[i]] <- data.frame(sampleID = temp, counts = sample(1:50, length(temp)), stringsAsFactors = F)
}

# save copy as test.data2 for later use
test.data2 <- test.data1


  
##### Changing column names

# You can change column names directly using strings
s1 <- data.frame(names = c("a", "b", "c", "d", "e"),
                 counts = 1:5)

s2 <- data.frame(names = c("a", "b", "c", "d", "e"),
                 counts = 6:10)

colnames(s2) <- c("newname", "newcounts")


# If you want to change just one of the colnames, you can specify this using square brackets [ ]
colnames(s1)[2] <- "newcounts"


##### Now lets do this on our test.data1 list!

# First lets change the column names of each dataframe so that the counts column is labelled with the sampleID
for(i in names(test.data1)){
  colnames(test.data1[[i]])[2] <- paste0("counts.", i)
}


# You can change all column names at once if you provide a VECTOR of the same length as the column names
for(i in names(test.data1)){
  colnames(test.data1[[i]]) <- c("alex", paste0("counts.", i))
  print(test.data1)
}


# Now we make a loop to merge our 5 dataframes (test.data1) into a single dataframe called 'output'
output <- test.data1[[1]]
for(i in test.data1[2:5]){
  output <- merge(x = output, y = i, by = "sampleID")
}


# Generating test data 2
# Randomly delete 5 genes from each dataframe in list
for(i in 1:length(test.data2)){
  test.data2[[i]] <- test.data2[[i]][-sample(1:nrow(test.data2[[i]]), 5),]
}


# Task1: change the names of the 'counts' column in order to reflect the sample, then merge the dataframes into one

# First lets change the column names of each dataframe so that the counts column is labelled with the sampleID
merged.data <- list()
for(i in names(test.data2)){
  colnames(merged.data[[i]])[2] <- paste0("counts.", i)
}


# Now we make a loop to merge our 5 dataframes (test.data1) into a single dataframe called 'output'
merged.output <- merged.data[[1]]
for(i in merged.data[2:5]){
  merged.output <- merge(x = merged.output, y = i, by = "sampleID")
}



# Task2: do same as above, but this time instead of using merge: 1) manually subset shared genes, 2) order dataframes into same order, 3) cbind columns of the dataframe

# First get list of shared genes
shared.genes <- test.data2[[1]]$sampleID[
  test.data2[[1]]$sampleID %in% test.data2[[2]]$sampleID &
    test.data2[[1]]$sampleID %in% test.data2[[3]]$sampleID &
    test.data2[[1]]$sampleID %in% test.data2[[4]]$sampleID &
    test.data2[[1]]$sampleID %in% test.data2[[5]]$sampleID
  ]


# Make one loop which: dynamically changes names, subsets shared genes and reorders dataframes
newdat <- list()
for(i in names(test.data2)){
  colnames(test.data2[[i]])[2] <- paste0("counts.", i)
  newdat[[i]] <- test.data2[[i]][test.data2[[i]][,"sampleID"] %in% shared.genes,]
  newdat[[i]] <- newdat[[i]][order(newdat[[i]]$sampleID),]
}


# Rows are in the now in the same order, so we can use cbind to combine the columns
newdat <- cbind(newdat[[1]], newdat[[2]], newdat[[3]], newdat[[4]], newdat[[5]])


# We now have duplicated columns (the sample IDs), so we need to keep only those which ARE NOT duplicated
newdat[,!duplicated(colnames(newdat))]

