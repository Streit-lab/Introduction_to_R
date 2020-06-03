
# Installs packages from CRAN repository online
install.packages('pheatmap')


# This will remove the package from your library - this will only take place once the current R session is restarted
remove.packages('pheatmap')


# Loads installed package into current R session - you need to load the package every time
install.packages('pheatmap')
library(pheatmap)


# Functions have brackets after them
# c stands for concatenate/combine - it will combine the arguments you provide it with
c()


# Functions take arguments which are separated by commas

a <- c(1, 4, 7)


# We can also check the class of the data using the class() function

class(a)


# Using quotation marks to set character data

b <- c("hello", "world")

class(b)


# This is the case even if you're using inserting numbers as strings

c <- c("1", "2", "3")

class(c)


# Vectors can only take one type of data - this will become a character vector

d <- c("hello", "world", 1, 3)

class(d)


# You can convert data types - i.e. numeric characters can be converted to numeric data using as.numeric()

# However, you cannot turn non-numeric characters into numeric data types - this will force NAs instead


as.numeric(c("hello", "world", 1, 3))

as.numeric(c("1", "2", "3"))



# To access elements of a vector, use squared brackets

a[3]


# Vectors are 1 dimensional

1:10
c(1,2,3,4,5,6,7,8,9,10)


# Matrices and dataframes are 2 dimensional

mat_1 <- matrix(data = 1:10, ncol = 2)


# To access elements of a matrix or dataframe - specify row and column position [row,col]

# access row 3, col 2
mat_1[3,2]

# access all rows from col 1
mat_1[,1]


# Let's make a test dataframe

# This dataframe has two columns named "names" and "heights"

test.heights <- data.frame("names" = c("Alex", "Scarlet", "Fereshteh"), "height" = c(200, 160, 155), stringsAsFactors = F)


# You can see that columns of dataframes can contain different data types

class(test.heights[,1])
class(test.heights[,2])


# As with vectors, you can subset columns and rows by positions as well as named matches

test.heights[,"names"]


# One major difference between matrices and dataframes!

# Matrices can only store 1 type of data...

# Here I am setting 4 vectors (3 numeric - 1 character)
a <- 1:5
b <- 6:10
c <- 11:15
d <- c("Alex", "Scarlet", "Vida", "Ailin", "Owen")


# cbind turns these into a matrix
test.matrix <- cbind(a, b, c, d)


# Matrices can only store one class of data
class(a)
class(d)

test.matrix[,1]
class(test.matrix[,1])



##### Subsettting dataframes by a match in one column

# One way to do this would be to assign the rownames as the column you are searching for - and then subset based on rowname match
test.dataframe <- data.frame(a,b,c,d)
rownames(test.dataframe) <- test.dataframe[,4]
test.dataframe["Vida",]


# Another way would be to use boolean operators
test.dataframe <- data.frame(a,b,c,d)
"Vida" %in% test.dataframe[,4]

test.dataframe[,4] %in% "Vida"

test.dataframe[test.dataframe[,4] %in% "Vida",]

test.dataframe[test.dataframe[,4] %in% "Vida", 4]

