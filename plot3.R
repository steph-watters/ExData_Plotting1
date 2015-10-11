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
png(filename = "plot3.png", width = 480, height = 480, units = "px", 
    pointsize = 12, bg = "transparent", res = NA, type = "quartz")

## Create the plot including the legend
with(dataset, plot(`Time`, `Sub Metering 1`, type = "l", xlab = "",
                   ylab = "Energy sub metering"))
with(dataset, lines(`Time`, `Sub Metering 2`, col = "red"))
with(dataset, lines(`Time`, `Sub Metering 3`, col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()