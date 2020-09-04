# Download data file, and unzip
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "PowerConsumption.zip"))
unzip("PowerConsumption.zip")

# Load packages
library(data.table)
library(dplyr)
library(lubridate)

# Read "household_power_consumption.txt" data into PowerConsumption2days
# Convert Date column into Date dataclass
# Filter for only the date ranges required for the assignment
# Rename to generate clean column names
PowerConsumption2days <- data.table::fread("household_power_consumption.txt", na.strings="?")
PowerConsumption2days <- mutate(PowerConsumption2days, Date = dmy(Date))
PowerConsumption2days <- filter(PowerConsumption2days, Date >= ymd("2007-02-01"), Date <= ymd("2007-02-02"))
PowerConsumption2days <- rename(PowerConsumption2days, 
				GlobalActivePower = Global_active_power,
				GlobalReactivePower = Global_reactive_power,
				GlobalIntensity = Global_intensity,
				Submetering1 = Sub_metering_1,
				Submetering2 = Sub_metering_2,
				Submetering3 = Sub_metering_3)

# Paste 'Date' 'Time' columns and convert to 'POSIXct'
# Create PowerConsumption2daysTime data table with converted values
# Rename column in PowerConsumption2daysTime data.table to 'Datetime'
PowerConsumption2daysTime <- strptime(paste(PowerConsumption2days$Date, PowerConsumption2days$Time), "%Y-%m-%d %H:%M:%S")
PowerConsumption2daysTime <- data.table(PowerConsumption2daysTime)
PowerConsumption2daysTime <- rename(PowerConsumption2daysTime, Datetime = PowerConsumption2daysTime)

# Plot Submetering1,2,3 vs Datetime
# Insert legend
png("plot3.png", width = 480, height = 480)
plot(x = PowerConsumption2daysTime$Datetime, y= PowerConsumption2days$Submetering1,
	type="l", xlab = "", ylab = "Energy sub metering")
lines(x = PowerConsumption2daysTime$Datetime, y= PowerConsumption2days$Submetering2, 
	type="l", col = "red")
lines(x = PowerConsumption2daysTime$Datetime, y= PowerConsumption2days$Submetering3,
	type="l", col = "blue")
legend("topright", col = c("black", "red", "blue"),
		c("Submetering1", "Submetering2", "Submetering3"),
		lty = c(1, 1, 1), lwd = c(2, 2, 2))
dev.off()