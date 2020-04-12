find_a_town <- function(x)
{
  cleanNIPostcodeData <- read.csv("cleanNIPostcodeData.csv")
  #na.omit(cleanNIPostcodeData)
  x <- merge(x,cleanNIPostcodeData,by.x="Location",by.y="Primary_Thorfare",all.x=TRUE)
  
  #class(Town)
  #return(Town)
  }