# Introduction to custom functions

# The examples functions have been made to replicate the base R sum() function and are therefore
# for illustrative purposes only.

# R has many base functions and thousands of packages which can handle most of the tasks you will need to
# carry out. However, there are instances that you will need to make your own functions.


# basic function syntax
function(arg1, arg2){
  someprocess
  return(output)
}


# custom function to add two elements together
add <- function(x,y){
  return(x+y)
}

# arguments are assigned in order, unless they are exlicitly stated

samplefunc <- function(x,y){
  print(x)
  print(y)
}

samplefunc(1,2)

samplefunc(y = 1, x = 2)

# only the arguments specified in a function can be provided
add <- function(x,y){
  return(x+y)
}

add(1,2,3)

# if an argument doesnt have a default, it must be provided
add <- function(x,y,z){
  return(x+y+z)
}

add(x = 1, y = 2)


# when default arguments are assigned, arguments do not have to be provided
add <- function(x = 0, y = 0, z = 0){
  return(x+y+z)
}

add()
add(x = 1, y = 3, z = 5)


# There are many situations where you want to carry out an operation on a vector of variable lengths
# For example we might want to add the vector elements together without knowing how long our vector is

# here is our vector - how can we add these together using a for loop?
c(1,2,3,4,5)

# we need to initiate temp outside of the loop as either: 0, or the first value of our vector. This provides us with an initial value to add to
sum.loop <- function(x){
  temp = x[1]
  for(i in x[2:length(x)]){
    temp = temp + i
  }
  return(temp)
}


sum.loop <- function(x){
  temp = 0
  for(i in x){
    temp = temp + i
  }
  return(temp)
}



# we can use an ellipsis in order to supply non-hard coded arguments

ellip <- function(...){
  args <- c(...)
  temp = 0
  for(i in args){
    temp = temp + i
  }
  return(temp)
}

ellip(x = 1, y = 4, h = 8, v = 7)




# the syntax to if else statements is as follows
# the statement between the () should return TRUE or FALSE, which dicates whether the operation in {} is carried out
if(TRUE){
  some_operation
} else if(TRUE){
  some_other_operation
} else{
  final_operation
}


# we can use if else statements to choose which operation we want to carry out in our custom function
sum.sub <- function(operation, ...){
  if(operation == "subtract"){
    return(sum(-c(...)))
  } else if (operation == "add"){
    return(sum(c(...)))
  } else if (operation == "multiply"){
    temp = 1
    for(i in c(...)){
      temp = temp*i
    }
    return(temp)
  } else {stop("can only add, subtract or multiply")}
    
}

sum.sub(operation = "add", 1,2,3,4)
sum.sub(operation = "subtract", 1,2,3,4)
sum.sub(operation = "multiply", 1,2,3,4)
sum.sub(operation = "sum", 1,2,3,4)


