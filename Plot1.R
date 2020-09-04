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
PowerConsumption2days <- filter(PowerConsumption2days, 
								Date >= ymd("2007-02-01"), Date <= ymd("2007-02-02"))
PowerConsumption2days <- rename(PowerConsumption2days, 
				GlobalActivePower = Global_active_power,
				GlobalReactivePower = Global_reactive_power,
				GlobalIntensity = Global_intensity,
				Submetering1 = Sub_metering_1,
				Submetering2 = Sub_metering_2,
				Submetering3 = Sub_metering_3)

# Plot histogram for GlobalActivePower vs Frequency
# Save as "plot1.png"
png("plot1.png", width = 480, height = 480)
hist(PowerConsumption2days$GlobalActivePower, 
     col = "red", main = "Global Active Power",
     xlab = "Global Active Power (Kilowatts)")
dev.off()