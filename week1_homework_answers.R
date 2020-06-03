# so this week we went through setting variables. making vectors, matrices and dataframes. Here are a few questions for you to work your way through.
# I don't want the answers - I want you to provide the code which I can use to get the answers. They are tricky and might require you to google a bit,
# but it's not supposed to be easy so spend some time doing these and we can recap next week.

# Good luck!
library(dplyr)
# task 1: make a character vector named my_vector containing 5 elements
c("Alex", "Scarlet", "Fereshteh")

# task 2: make a matrix containing numbers 1:100 split across 10 columns
matrix(data = 1:100, ncol = 10)

# Here is a test dataframe I have created from the metadata for my 10x scRNSseq data
test <- read.csv("./test_data/week1_homework_scRNAseq_test.csv")

# task 3: how many columns does the dataframe have?
ncol(test)

# task 4: how many cells are female? Hint: you can use sum and the boolean operator to count TRUE values i.e. sum(x %in% y)

# to view first few lines of - n will set the number of rows to print
head(test, n = 5)
# to view final few lines of 
tail(test, n = 5)

# SO - lets count female cells!
sum(test[,"sex"] == "female")

# task 5: subset the rows which are male

test[test[colnames(test) %in% c('sex')]=='male',]

# get T/F vector for which cells are male 
TF <- test[,"sex"] == "male"
test[TF,]

# dplyr - alternative to using base R, but logic is obscured
# %>% is a pipe, it passes the first argument through to the second functions
test %>%
  filter(sex == "male") %>%
  filter(seurat_clusters == 0) %>%
  arrange(percent.mt)

# task 6: subset a vector of the cell_IDs which are from stage hh4 (orig.ident column)
test[test[,"orig.ident"] == "hh4", "cell_ID"]




