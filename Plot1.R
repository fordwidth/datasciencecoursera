# Examine how household energy usage varies over a 2-day period in February, 2007
# histogram of Global_active_power
# Downloaded data
# fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# wget https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip("d396qusza40orc.cloudfront.net") 
# file of concern: 132960755 Oct 12  2012 household_power_consumption.txt
# place in working directory 

power <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, skip = 1)
names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                  "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Change relevant data to time and date
library(lubridate)
power$Date <- dmy(power$Date)

# isolate data for time point of concern
x <- subset(power, Date == as.Date("2007-02-01"))
y <- subset(power, Date == as.Date("2007-02-02"))
power <- rbind(x, y)
rm(x, y)

# Plot histogram of Global_active_power
# Save as PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename = "plot1.png", width = 480, height = 480)
hist(power$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off() 
rm(power)