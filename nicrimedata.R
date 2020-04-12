# Merging all the datasets. 
#All the files are stored in the folder NI Crime Data inside the working directory
getwd()
library(plyr)
library(readr)
library(dplyr)
mydir = "NI Crime Data"
myfiles = list.files(path=mydir, pattern="*.csv", full.names=TRUE)
myfiles
dat_csv = ldply(myfiles, read_csv)
dat_csv
View(dat_csv)
AllNICrimeData <- dat_csv
# Number of rows and columns in AllNIcrimedata
str(AllNICrimeData)
# Removing unnecessary columns
AllNICrimeData <- AllNICrimeData[,-c(1,3,4,8,9,11,12)]
View(AllNICrimeData)
#structure of the new dataset
str(AllNICrimeData)
AllNICrimeData
# Assigning short forms to Crime type
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Anti-social behaviour"] <- "ASBO"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Bicycle theft"] <- "BITH"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Burglary"] <- "BURG"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Criminal damage and arson"] <- "CDAR"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Drugs"] <- "DRUG"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Other theft"] <- "OTTH"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Public order"] <- "PUBO"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Robbery"] <- "ROBY"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Shoplifting"] <- "SHOP"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Theft from the person"] <- "THPR"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Vehicle crime"] <- "VECR"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Violence and sexual offences"] <- "VISO"
AllNICrimeData$`Crime type`[AllNICrimeData$`Crime type`=="Other crime"] <- "OTCR"
View(AllNICrimeData)
# Calculating the frequency of occurnce of each crime type
freq <- table(AllNICrimeData$`Crime type`)
freq
View(freq)
# plotting frequency,simple plot and bar plot
plot(freq)
barplot(freq)
library(RColorBrewer)
coul <- brewer.pal(8, "Set2") 
barplot(freq,col=coul)
class(freq)
freq1 <- freq[1:8]
barplot(freq1,col=coul,main = "Crimetype frequency",ylab = "frequency")
# removing on or near before street name
AllNICrimeData[,4] <- sub("On or near", "", AllNICrimeData[,4])
View(AllNICrimeData)
#Replacing empty columns by NA in location column
AllNICrimeData$Location[AllNICrimeData$Location==""] <- NA
View(AllNICrimeData)
# removes any rows that contains NA - listwise deletion
#new_data <- na.omit(AllNICrimeData)
# Random sampling --------------------------------------------------------
# Selecting a random sample AllNICrimeData
my_sample <- new_data[sample(1:nrow(new_data), "5000", replace = TRUE),]
my_sample
View(my_sample)
#setting the seed value
#set.seed(100)
random_crime_sample <- my_sample
#Creating function called find a town which uses Cleanpostcode dataset
# It find the correct location for each location variable
# within the random crime_sample
#This function accepts a data frame
getwd()
source("find_a_town.R")
#random_crime_sample1 <- find_a_town(random_crime_sample)
#random_crime_sample <- data.frame(random_crime_sample,Town)
#set.seed(100)
my_sample$Location <- toupper(my_sample$Location)
random_crime_sample <- find_a_town(my_sample)
View(random_crime_sample)
#random_crime_sample$Location[random_crime_sample$Location==""] <- NA
#View(random_crime_sample)
#library(tidyr)
#View(random_crime_sample)
#df <- subset(random_crime_sample, !is.na(Location))
#is.na(df$Location)
#random_crime_sample <-df
# The function run succesfully and it merged the two dataframes
# However,the values in the second dataframe found to be null. This has to be resolved
random_crime_sample <- random_crime_sample[,-c(6:20)]
#View(random_crime_sample)
#Village_data <- read.csv("VillageList.csv")
# Writing the final output
write.csv(random_crime_sample,'random_crime_sample.csv')
