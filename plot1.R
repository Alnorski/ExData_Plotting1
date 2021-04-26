library(dplyr)
library(readr)
library(datasets)

#Readingdata
rawData <- read.delim("household_power_consumption.txt", 
                      header = TRUE, sep = ";")

#Filtering specific dates, and adding a POSIXct time column
day1 <- filter(rawData, Date == "1/2/2007")
day2 <- filter(rawData, Date == "2/2/2007")
coreData <- rbind(day1, day2)

time <- paste(coreData[,1], coreData[,2])
time <- strptime(time, "%d/%m/%Y %H:%M:%S")
coreData <- cbind(time, coreData)

#First Plot
png("plot1.png", width=480, height=480)
hist(as.numeric(coreData$Global_active_power), 
     col = "red", main="Global Active Power",
     xlab="Global Active Power(kilowatts)")
dev.off()