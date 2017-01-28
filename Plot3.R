# Plot3.R
# Examine how household energy usage varies over a 2-day period in February, 2007
# Downloaded data
# fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# wget https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip("d396qusza40orc.cloudfront.net") 
# file of concern: 132960755 Oct 12  2012 household_power_consumption.txt
# place in working directory 

power <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, skip = 1)
names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Change relevant data to time and date
library(lubridate)
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)

# isolate data for time point of concern
temp <- subset(power, Date == as.Date("2007-02-01"))
y <- subset(power, Date == as.Date("2007-02-02"))
power <- rbind(temp, y)
rm(temp, y)

# Need to sort by Date and then by time. 
library(dplyr)
power <- arrange(power, Date, Time)

# Opening device
png(filename = "plot3.png", width = 480, height = 480)

# Plot 2 line plot; y = Global Active Power (kilowatts), x = c(Thu, Fri, Sat)
plot(power$Sub_metering_1,
     type = "l", ylab = "Energy sub metering", 
     xaxt = "n", 
     xlab = "", 
     col = "black")
lines(power$Sub_metering_2, col = "red")
lines(power$Sub_metering_3, col = "blue")

# label x axis with weekdays     !Printing only Thu! 
axis(side = 1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1,
       col = c("black", "orange", "blue"))
dev.off() 