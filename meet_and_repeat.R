# Data Wrangling - Week 6 
# Hanieh Heidarpour Kiaei


# Task 1


# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)

# Look at the (column) names of BPRS
colnames(BPRS)

# Look at the structure of BPRS
str(BPRS)

# Print out summaries of the variables
summary(BPRS)


# read in the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Look at the (column) names of RATS
colnames(RATS)

# Look at the structure of RATS
str(RATS)

# Print out summaries of the variables
summary(RATS)



# Task 2


library(dplyr)
library(tidyr)

# Factor treatment & subject in BPRS data set
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group in RATS data set
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)



# Task 3


# Convert the BPRS to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  mutate(week = as.integer(substr(weeks, 5, 5))) %>%
  arrange(weeks) 


# Convert RATS data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD", values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)



# Task 4


# Look at the (column) names of new BPRSL
colnames(BPRSL)

# Look at the structure of new BPRSL
str(BPRSL)

# Print out summaries of the variables
summary(BPRSL)


# Look at the (column) names of new RATSL
colnames(RATSL)

# Look at the structure of new RATSL
str(RATSL)

# Print out summaries of the variables
summary(RATSL)



write.table(BPRSL, "data/BPRSL.txt")
write.table(RATSL, "data/RATSL.txt")


 