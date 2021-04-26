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

#Third Plot 
png("plot3.png", width=480, height=480)
plot(coreData$time,coreData$Sub_metering_1, type="n", xlab="",
     ylab="Energy sub metering")
with(coreData,lines(time, as.numeric(as.character(Sub_metering_1))))
with(coreData,lines(time, as.numeric(as.character(Sub_metering_2)), col="red"))
with(coreData,lines(time, as.numeric(as.character(Sub_metering_3)), col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
