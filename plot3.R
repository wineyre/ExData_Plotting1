## This R script is created for Exploratory Data Analysis course project 1.
## This R script is created for plot 3.
## This R script performs following tasks in order: download and unzip data, clean data, and plot.

if (!file.exists("./data")) {
	dir.create("./data")
}

if (!file.exists("./data/PowerConsumptionDataset")) {
	## Download file
	setInternet2(use = TRUE)
	fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	zipfile <- "./data/PowerConsumptionDataset.zip"
	download.file(fileURL, destfile=zipfile)
	## Unzip the source file
	unzip(zipfile, exdir = "./data")
	## Remove zipfile
	## file.remove(zipfile)
}

## Read Data
data <- read.table("./data/household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";")

## Convert Date to Date format
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Subset data to include 2007-02-01 and 2007-02-02 data only
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

## Convert measurements to numeric format
for (i in 3: length(names(data))){
	data[ , i] = as.numeric(data[ , i])
}

## Reassign Time column to include Date and Time and convert to POSIXlt format
data$Time <- paste(data$Date, data$Time)
data$Time <- strptime(data$Time, "%Y-%m-%d %H:%M:%S")

## Plot 3
png(file = "plot3.png", height = 480, width = 480, units = "px")
## plot Sub_metering_1
plot(data$Time, data$Sub_metering_1,type = "l",col = "black", xlab = " ", ylab = "Energy sub metering")
## add Sub_metering_2 to the plot
lines(data$Time, data$Sub_metering_2, col = "red")
## add Sub_metering_3 to the plot
lines(data$Time, data$Sub_metering_3, col = "blue")
## add legend to the plot
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## lty = 1 solid line
dev.off()