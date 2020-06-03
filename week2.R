
#### Week 2


##### In this session we will look at list data structures, and ordering and combining dataframes stored within lists

# RDS files are saved R objects from a previous R session
# Reading in bulk RNAseq data
RNAseq.data <- readRDS(file = 'test_data/fake_bulkdata.RDS')


# Use summary() to access information as to the structure of the data
summary(RNAseq.data)
# RNAseq.data is a list

# It contains 7 dataframes
length(RNAseq.data)


##### How do lists work?

# Lists can store any combination of data types, including other lists (see "c" in list below) let's make an example list
mylist <- list("a" = c(1,2,3,4,5),
               "b" = matrix(data = 1:100, nrow = 10),
               "c" = list("a" = "b"))

length(mylist)
names(mylist)


##### Accessing elements of a list

# You can subset a list by position, TRUE/FALSE vector, or by name
mylist["a"]
mylist[1]
mylist[c(T,F,T)]


# Using single brackets subsets the list including the names for those list elements
# This means that the object returned will still be a list (even if it is of length == 1)
mylist[1]
class(mylist[1])


# In order to direcly access the CONTENTS of that list element and modify them, we need to use double square brackets
mylist[[1]]
class(mylist[[1]])

# Going back to our test.data - we have 7 samples, each stored as a dataframe in a list if we look at the first dataframe in the list, we can see it contains gene name and gene counts
head(RNAseq.data$SOX8_1)

# The order of the rows is clearly not the same between the datasets
head(RNAseq.data$SOX8_1)
head(RNAseq.data$SOX8_2)

# Here we need to check if the genes in sample 1 are present in sample 2
# To do this we can use the operator %in%. This returns TRUE or FALSE values for each S1 element (S1 %in% S2) depending on its presence in S2
c("a", "d") %in% c("a", "b", "c")


# However the order in which you specify the arguments can give different outputs i.e this will give all T, even through 'e' is not present in the first vector
c("a", "b", "c", "d") %in% c("a", "b", "c", "d", "e")

# Intersect compares both arguments against each other and only returns those which are shared
intersect(c("a", "b", "c", "d", "f", "h"), c("a", "b", "c", "d", "e", "z", "h"))

# any() will check to see if any of the elements are true, all will check to see if ALL are true
any(c("a", "b", "c") %in% c("a", "b"))
all(c("a", "b", "c") %in% c("a", "b"))

# Now we can check this in our actual dataset
# all() genes are shared between the datasets, however they are not in the same order

all(RNAseq.data$SOX8_1[,"gene_name"] %in% RNAseq.data$SOX8_2[,"gene_name"])


##### Genes can have multiple ENSEMBL IDs and therefore once you lose this information you may end up with duplicated gene names
RNAseq.data$SOX8_1$gene_name[duplicated(RNAseq.data$SOX8_1$gene_name)]

# You can make values unique using make.unique which will append a suffix if they are duplicated
make.unique(c("a", "b", "c", "c", "c", "b", "d"))

# It is better to use EnsemblIDs for this reason**, however for now lets just remove the genes which are duplicated
# Using ! inverses a T/F vector - allowing us to keep only the genes which ARE NOT duplicated
temp2 <- RNAseq.data$SOX8_1[!duplicated(RNAseq.data$SOX8_1$gene_name),]

# After removing these genes we can see there are no longer any duplicated gene names
any(duplicated(temp2$gene_name))

# We now need to remove duplicated gene names in ALL 7 samples!!! HOW DO WE DO THIS?
# We can use a **for loop!**

##### For loops - The basics

# This for loop will print out the variable i for every element in 1:5
# Let's think about this - 1:5 returns the following array: [1] 1 2 3 4 5
# Therefore in the following for loop, i first becomes 1, then 2, then 3... and is subsequently printed
for(i in 1:5){
  print(i)
}

# Just as we can provide numbers to for loops, we can also provide character vectors
names = c("Alex", "Scarlet", "Vida")
for(i in names){
  print(i)
}

##### Now let's apply this for loop to in order to remove duplicated genes from all of our samples in RNAseq.data
  
# The gene names can be accessed like this
RNAseq.data[[1]][,"gene_name"]


# Because we want to output our results to a new list, we need to initialise an empty list which I have called mylist, which we then populate in the loop
# create empty list
mylist <- list()

# for loop
for(i in names(RNAseq.data)){
  mylist[[i]] <- RNAseq.data[[i]][!duplicated(RNAseq.data[[i]]$gene_name),]
}

# We can now see that there are no duplicated gene names in the dataframes
all(duplicated(mylist[[1]]$gene_name))



