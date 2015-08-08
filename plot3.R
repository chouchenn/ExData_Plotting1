# creates plot 3: plot of Energy Sub-metering
# -------------------------------------------------

# loads the data
tab <- loadHouseholdPowerConsumptionData()

# opens graphic device
png(file = "plot3.png", width = 480, height = 480)

# creates plot
par(cex = 0.95)
plot(tab$Sub_metering_1, ylab = "Energy sub metering", xlab = "", xaxt = "n", type = "l")
with(tab, points(Sub_metering_2, col = "red", type = "l"))
with(tab, points(Sub_metering_3, col = "blue", type = "l"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))
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