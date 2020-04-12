getwd()
# To get the working directory where R reads files.
# The dataset path is not hard coding to avoid running compatablitly issues
NIpostcode <- read.csv("NIpostcodes.csv")
# Displaying the structure of the dataframe
str(NIpostcode)
#Displaying the first 10 rows of the dataframe.
#NIpostcode[1:10]
#View(NIpostcode[1:10])
head(NIpostcode, n=10)
View(head(NIpostcode, n=10))
View(NIpostcode)
# Giving titles to the attributes of the data
title <- c("Organisation_name","Sub_bulding_name","Building_name","Number","Primary_Thorfare","Alt_Thorfare","Secondary_Thorfare","Locality","Townland","Town","Country","Postcode","x-coordinates","y-coordinates","Primarykey")
#assigning title to the dataframe using names function
names(NIpostcode) <- title
View(NIpostcode)
# Replacing missing values in some columns  with NA
NIpostcode$Organisation_name[NIpostcode$Organisation_name==""] <- NA
NIpostcode$Locality[NIpostcode$Locality==""] <-NA
NIpostcode$Building_name[NIpostcode$Building_name==""] <-NA
NIpostcode$Town[NIpostcode$Town==""] <- NA
NIpostcode$Townland[NIpostcode$Townland==""] <- NA
is.na(NIpostcode)
install.packages("naniar")
library(naniar)
#vis_miss(NIpostcode)
gg_miss_var(NIpostcode)
sum(is.na(NIpostcode))
new_data <- data.frame(NIpostcode$Organisation_name,NIpostcode$Locality,NIpostcode$Building_name,NIpostcode$Town)
gg_miss_var(new_data)
summary(new_data)
colSums(is.na(new_data))
# Moving the primary key to the start of the dataset
#my_data2 <- new_data[ c(4,1:3)]
#my_data2
#head(my_data2,n=10)
NIpostcodeclean <- NIpostcode[c(15,1:14)]
CleanNIPostcodeData <- NIpostcodeclean
View(head(NIpostcodeclean,n=10))
#index <- which(NIpostcode$Town=="LIMAVADY"|NIpostcode$Townland=="LIMAVADY"|NIpostcode$Locality=="LIMAVADY")
# storing those rows which contain Limavady in town,townland or locality
library(dplyr)
Limavady <-NIpostcode %>% select(title) %>% filter(NIpostcode$Town=="LIMAVADY"|NIpostcode$Townland=="LIMAVADY"|NIpostcode$Locality=="LIMAVADY")
#View(NIpostcode)
View(Limavady)
#write.csv(NIpostcodeclean,'cleanNIPostcodeData.csv')
CleanNIPostcodeData$Primary_Thorfare <- as.character(CleanNIPostcodeData$Primary_Thorfare)
write.csv(CleanNIPostcodeData,'cleanNIPostcodeData.csv')

