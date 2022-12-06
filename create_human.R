# Data Wrangling
# Hanieh Heidarpour Kiaei
# Assignment 5



### creating 'human' data set ###



library(readr)

# read the data sets
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


# explore 'hd' data set 
str(hd)
nrow(hd)
ncol(hd)
summary(hd)

# explore 'gii' data set 
str(gii)
nrow(gii)
ncol(gii)
summary(gii)


library(dplyr)

# rename the variables of 'hd' data set
hd2 <- hd %>% 
  rename(HDIRa = "HDI Rank",
         coun = "Country",
         HDI = "Human Development Index (HDI)",
         lifeExp = "Life Expectancy at Birth",
         eduExp = "Expected Years of Education",
         eduMean = "Mean Years of Education",
         GNI = "Gross National Income (GNI) per Capita",
         GNI_HDI = "GNI per Capita Rank Minus HDI Rank"
  )

        
# rename the variables of 'gii' data set
gii2 <- gii %>% 
  rename(GIIRa = "GII Rank",
         coun = "Country",
         GII = "Gender Inequality Index (GII)",
         matMor = "Maternal Mortality Ratio",
         adolBir = "Adolescent Birth Rate",
         parli = "Percent Representation in Parliament",
         edu2F = "Population with Secondary Education (Female)",
         edu2M = "Population with Secondary Education (Male)",
         labF = "Labour Force Participation Rate (Female)",
         labM = "Labour Force Participation Rate (Male)"
  )
         
         

# mutate a new variable: edu2F/edu2M
gii2 <- gii2 %>% 
  mutate(edu2F/edu2M , labF/labM)


# join two data sets
human <- inner_join(hd2, gii2, by = "coun")

# save the 'human' data set in data folder
write.csv(human, "human.csv")




### exploring and describing the 'human' data set ###


str(human)
dim(human)

# The 'human' data set is a data set created by combining two distinct data sets including 'human development' and 'gender inequality' data set. 
# After joining two data sets, our new data set consists of 195 observations on 19 variables meaning a data frame with 195 rows and 19 columns.
# 1 out of 19 variables is character, others are numeric variables. 
# Joining data sets are done based on 'country' variable which existed in both data sets. 
# To get shorter names for variables, we renamed the columns as shown above. 


## Task 1

# mutate the GNI variable to numeric
library(stringr)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric 


## Task 2

# exclude unneeded variables
library(dplyr)
keep <- c("coun", "edu2F", "labF", "lifeExp", "eduExp", "GNI", "matMor", "adolBir", "parli")


## Task 3

# remove all rows with missing values
human <- select(human, one_of(keep))
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human,  complete.cases(human))


## Task 4

# remove the observations which relate to regions instead of countries
last <- nrow(human) - 7
human_ <- human[1:last, ]


## Task 5

# define the row names of the data by the country names and remove the country name column from the data
human_ <- as.data.frame(human_)
rownames(human_) <- human_$coun
human_ <- select(human_, -coun)

# save the human data in your data folder including the row names
write.csv(human_, "human.txt")




