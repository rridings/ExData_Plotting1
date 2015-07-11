# Load data frame from source file
data <-read.table("household_power_consumption.txt", header=TRUE, sep=";")

# Create new date column from original date
data$newData <- as.Date(data$Date, "%d/%m/%Y")

# Subset data frame for 2/1/2007 to 2/2/2007
data <- subset( data, data$newData >= "2007-02-01" & data$newData <= "2007-02-02" )

# Convert from factor to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Create datetime column
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Open png device
png("plot2.png", 480, 480)

# Plot Global Active Power vs DateTime
plot(data$DateTime, data$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="n")
lines(data$DateTime, data$Global_active_power,type="l")

# Close png device
dev.off()