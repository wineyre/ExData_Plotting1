## This R script is created for Exploratory Data Analysis course project 1.
## This R script is created for plot 1.
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

## Plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, col = 'red', main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()