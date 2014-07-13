# Set the working directory
setwd("D:/myWork/R Files/Repo/DataScience/Exploratory Data Analysis")

# Load the data into a dataframe. I have loaded only the first 70,000 rows since this contains the specific dates in question
dfData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 70000)

# Subset the specific dates
data <- subset(dfData, dfData$Date == "1/2/2007" | dfData$Date == "2/2/2007")

# Combine the date and time columns
data$datetime <- paste(data$Date, data$Time)

# Drop the Date and Time cols since we have combined these and created a new col
data$Date <- NULL
data$Time <- NULL

# Reorder the cols by index so that the datetime is the first col
data <- data[c(8,1:7)]

data$datetime <- strptime(data$datetime, format = "%d/%m/%Y %H:%M:%S")

# Remove the initial data frame from memory
rm(dfData)

# Construct Plot 4 and save it to a PNG

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(data$datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(data$datetime, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_2"), bty = "n")

plot(data$datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
