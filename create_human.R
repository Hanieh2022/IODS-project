# Data Wrangling

## Task 2

library(readr)

# read the data sets
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


## Task 3

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


## Task 4

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
         
         
## Task 5

# mutate a new variable: edu2F/edu2M
gii2 <- gii2 %>% 
  mutate(edu2F/edu2M , labF/labM)


## Task 6

# join two data sets
human <- inner_join(hd2, gii2, by = "coun")

# save the 'human' data set in data folder
write.csv(human, "data/human.csv")

