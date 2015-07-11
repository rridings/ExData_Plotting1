# Load data frame from source file
data <-read.table("household_power_consumption.txt", header=TRUE, sep=";")

# Create new date column from original date
data$newData <- as.Date(data$Date, "%d/%m/%Y")

# Subset data frame for 2/1/2007 to 2/2/2007
data <- subset( data, data$newData >= "2007-02-01" & data$newData <= "2007-02-02" )

# Convert from factor to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Open png device
png("plot1.png", 480, 480)

# Create histogram without x axis
hist(data$Global_active_power, 
     main="Global Active Power", 
     col="red", 
     plot=TRUE, 
     xlab="Global Active Power (kilowatts)", 
     xlim=c(0,6), 
     ylim=c(0,1200),
     xaxt='n')

# Add x axis
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2))

# Close png device
dev.off()