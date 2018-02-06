# Exploratory analysis of gasoline data. 
# First approach to dataset with gasoline prices from individual retailers


# reads raw data
gasoline <- read.csv("~/Gasoline/gas data/gasoline.csv")
gasoline$date <- as.Date(gasoline$date) 
gasoline$address <- as.character(gasoline$address)
str(gasoline)

print(paste("hay", dim(gasoline)[1], "observaciones"))
