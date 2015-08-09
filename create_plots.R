##-----------------------------
## Exploratory Data Analysis
## Course Project
## 
## Ian C. Olson
##-----------------------------

setwd("~/Coursera/Exploratory Data Analysis/Week 1/Course Project")

## Read and subset the data
# Load Data
hpc <- read.table("household_power_consumption.txt", header=T, sep=";")
# Process dates
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")
# Select only the dates of interest
hpc <- hpc[hpc$Date=="2007-02-01"|hpc$Date=="2007-02-02",]
# Format the remaining data
hpc$Date <- strptime(paste(hpc$Date,hpc$Time), format="%Y-%m-%d %H:%M:%S")
hpc$Time <- NULL
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$Global_intensity <- as.numeric(as.character(hpc$Global_intensity))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))

# Reset so we only get one plot (if this is run multiple times)
par(mfrow=c(1,1))
# Clear the background
par(bg=NA)

## Histogram of Global Active Power
hist(hpc$Global_active_power
     ,xlab = "Global Active Power (kilowatts)"
     ,col = "red"
     ,main = "Global Active Power"
     )

dev.copy(png, file="plot1.png")
dev.off()

## Global Active Power vs. Day
plot(hpc$Date
     ,hpc$Global_active_power
     ,ylab = "Global Active Power (kilowatts)"
     ,xlab = ""
     ,type = "l"
     )

dev.copy(png, file="plot2.png")
dev.off()

## Energy Sub Metering vs. Day
# Open the device first for this plot, to avoid cutting off the legend
png(file="plot3.png")
# Clear the background
par(bg=NA)
plot(hpc$Date,hpc$Sub_metering_1
     ,col = "black"
     ,ylab = "Energy sub metering"
     ,xlab = ""
     ,type = "l")
lines(hpc$Date,hpc$Sub_metering_2, col = "red")
lines(hpc$Date,hpc$Sub_metering_3, col = "blue")
legend("topright"
       ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=c(1,1)
       ,col=c("black","red","blue")
       )

dev.off()

## Four plots
# Open the device first for this plot, to avoid cutting off the legend
png(file="plot4.png")
# Clear the background
par(bg=NA)
# 2x2 plots
par(mfrow=c(2,2))

# Global active power
plot(hpc$Date
     ,hpc$Global_active_power
     ,ylab = "Global Active Power"
     ,xlab = ""
     ,type = "l"
)

# Voltage
plot(hpc$Date
     ,hpc$Voltage
     ,ylab = "Voltage"
     ,xlab = "datetime"
     ,type = "l"
)

# Energy Sub Metering
plot(hpc$Date,hpc$Sub_metering_1
     ,col = "black"
     ,ylab = "Energy sub metering"
     ,xlab = ""
     ,type = "l")
lines(hpc$Date,hpc$Sub_metering_2, col = "red")
lines(hpc$Date,hpc$Sub_metering_3, col = "blue")
legend("topright"
       ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=c(1,1)
       ,col=c("black","red","blue")
       ,bty="n"
)

# Global Reactive Power
plot(hpc$Date
     ,hpc$Global_reactive_power
     ,ylab = "Global_reactive_power"
     ,xlab = "datetime"
     ,type = "l"
)

dev.off()