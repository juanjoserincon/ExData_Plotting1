## Exploratory Data Analisis - Johns Hopkins University course
## Project 1 
## Plot 3

## Downloading data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- paste("ElecPowCon", Sys.Date(), ".zip", sep="")
download.file(fileURL, destfile = fileName)
unzip(fileName)

## Reading data
data <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings ="?")

## Subseting data
data_clean <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

## Converting from data.frame to data.table
data_clean <- data.table(data_clean)

## Converting date and time into R classes
data_clean <- data_clean[, datetime:=as.POSIXct(strptime(paste(data_clean$Date, data_clean$Time), "%d/%m/%Y %H:%M:%S"))] 
Sys.setlocale("LC_TIME", "English")

## Plot 3
png(file = "plot3.png", width = 480, height = 480)
with(data_clean, plot(Sub_metering_1 ~ datetime, ylab ="Energy sub metering", xlab="", type="l"))
with(data_clean, lines(Sub_metering_2 ~ datetime, col = "red"))
with(data_clean, lines(Sub_metering_3 ~ datetime, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() 