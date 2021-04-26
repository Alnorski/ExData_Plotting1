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

#Fourth Plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

with(coreData,{
  plot(coreData$time, as.numeric(coreData$Global_active_power), 
       type = "l", 
       xlab="", 
       ylab="Global Active Power (kilowatts)")
  plot(coreData$time, as.numeric(coreData$Voltage), type = "l", 
       xlab="datetime",
       ylab= "Voltage")
  plot(coreData$time,coreData$Sub_metering_1, type="n", xlab="",
       ylab="Energy sub metering")
  with(coreData,lines(time, as.numeric(as.character(Sub_metering_1))))
  with(coreData,lines(time, as.numeric(as.character(Sub_metering_2)), col="red"))
  with(coreData,lines(time, as.numeric(as.character(Sub_metering_3)), col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         bty = "n",
         cex = 0.6)
  plot(coreData$time, as.numeric(coreData$Global_reactive_power), type = "l", 
       xlab="datetime",
       ylab="Global_reactive_pwoer")
})
dev.off()
