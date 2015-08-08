# creates plot 4: multiple plot of Energy Sub-metering
# -------------------------------------------------

# loads the data
tab <- loadHouseholdPowerConsumptionData()

# opens graphic device
png(file = "plot4.png", width = 480, height = 480)

# creates plots
par(mfrow = c(2, 2), cex.lab = 0.9)

# plot 1: global active power
plot(tab$Global_active_power, ylab = "Global Active Power", type = "l", xlab = "", xaxt = "n")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# plot 2: voltage
plot(tab$Voltage, ylab = "Voltage", type = "l", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# plot 3: energy sub metering
plot(tab$Sub_metering_1, ylab = "Energy sub metering", xlab = "", xaxt = "n", type = "l")
with(tab, points(Sub_metering_2, col = "red", type = "l"))
with(tab, points(Sub_metering_3, col = "blue", type = "l"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n", cex = 0.95)
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# plot 4: global reactive power
plot(tab$Global_reactive_power, ylab = "Global_reactive_power", type = "l", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# closes file device
dev.off()

#----------------------------------------------
# helper function: loads household power consumption data
#----------------------------------------------
loadHouseholdPowerConsumptionData <- function() {
  # reads first few lines to know colClasses
  tab <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";")
  classes <- sapply(tab, class)
  
  # reads the full table (knowing the number of rows, and colClasses)
  tab <- read.table("household_power_consumption.txt", header = TRUE, nrows = 2075259, sep = ";", colClasses = classes, na="?")
  
  # extracts Date vector from data 
  posixDate <- strptime(tab$Date, "%d/%m/%Y")
  posixDate <- as.Date(posixDate)
  
  # declares dates for filtering
  dates <- as.Date(c("2007-02-01", "2007-02-02"))
  
  # selects table entries for the requested dates
  tabFilt <- with(tab, tab[posixDate == dates[1] | posixDate == dates[2], ])
  
  return(tabFilt)
}