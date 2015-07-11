# Load data frame from source file
data <-read.table("household_power_consumption.txt", header=TRUE, sep=";")

# Create new date column from original date
data$newData <- as.Date(data$Date, "%d/%m/%Y")

# Subset data frame for 2/1/2007 to 2/2/2007
data <- subset( data, data$newData >= "2007-02-01" & data$newData <= "2007-02-02" )

# Convert from factor to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# Create datetime column
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Open png device
png("plot4.png", 480, 480)

# Create 2x2 grid display for plots
par(mfrow=c(2,2))

# Plot Global active power vs Datetime
plot(data$DateTime, data$Global_active_power, ylab="Global Active Power", xlab="", type="n")
lines(data$DateTime, data$Global_active_power,type="l")

# Plot Voltage vs Datetime
plot(data$DateTime, data$Voltage, ylab="Voltage", xlab="datetime", type="n")
lines(data$DateTime, data$Voltage,type="l")

# Plot Energy sub metering 1,2,3 vs DateTime
plot(data$DateTime, data$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")
lines(data$DateTime, data$Sub_metering_1, type="l", col="black")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")

# Add legend
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , 
       lty=1, col=c('black', 'red', 'blue'), bty='n')

# Plot Global reactive power vs DateTime
plot(data$DateTime, data$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="n")
lines(data$DateTime, data$Global_reactive_power,type="l")

# Close png device
dev.off()
