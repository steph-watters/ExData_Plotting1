## Read the dataset into R, selecting only the dates required from column 1
dataset <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), 
                      sep = ";", colClasses = c("factor", "character", "numeric", 
                                                "numeric", "numeric", "numeric", 
                                                "numeric", "numeric", "numeric"), 
                      na.strings = "?")

## Add column names to the dataset
colnames(dataset) <- c("Date", "Time", "Global Active Power", 
                       "Global Reactive Power", "Voltage", "Global Intensity", 
                       "Sub Metering 1", "Sub Metering 2", "Sub Metering 3")

## Change Date column to 'Date' class
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

## Change Time column to 'Time' class
dataset$timechange <- paste(dataset$Date, dataset$Time)
dataset$Time <- strptime(dataset$timechange, format = "%Y-%m-%d %H:%M:%S")
dataset$timechange <- NULL

## Create a PNG file
png(filename = "plot1.png", width = 480, height = 480, units = "px", 
    pointsize = 12, bg = "transparent", res = NA, type = "quartz")

## Create histogram
hist(dataset$`Global Active Power`, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()