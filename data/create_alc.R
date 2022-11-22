# Name: Hanieh Heidarpour kiaei

# Date: 21.11.2022

# Topic: Logistic Regression

# Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance



## Data wrangling

# Task 3

library(dplyr)

# read two data sets 
math <- read.table("data/student-mat.csv",sep=";",header=TRUE)
glimpse(math)
por <- read.table("data/student-por.csv",sep=";",header=TRUE)
glimpse(por)

# explore the structure and dimensions of the joined data

# These two data sets contains the data regarding student performance in secondary education
# specifically in two distinct subjects: Mathematics (mat) and Portuguese language (por).
# mat data set includes 395 rows/observations and 33 columns/variables. 
# There is 16 integers and 17 characters. we have 8 yes/no binary variables in this data set that makes it quite ideal
# for logistic regression analysis as in logistic regression we proceed with binary variables.
# The por data set is a larger one with 649 observations and 33 variables. 
# the number and type of variables is the same in two data sets. 

# Task 4

# give the columns that vary in the two data sets
free_cols <- (c("failures", "paid", "absences", "G1", "G2", "G3"))

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# look at the column names of the joined data set
colnames(math_por)

# glimpse at the joined data set
glimpse(math_por)

# explore the structure and dimensions of the joined data
# The new joined data set contains 256355 rows/observations and 66 columns/variables.

# Task 5

# Get rid of the duplicate records in the joined data set

# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# print out the columns not used for joining (those that varied in the two data sets)
colnames(free_cols)

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- "change me!"
  }
}

# glimpse at the new combined data
glimpse(alc)

# Task 6

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Task 7

glimpse(math_por)
glimpse(alc)

library(readr)

write_csv(math_por, "data/math_por.csv")
write_csv(alc, "data/alc.csv")

