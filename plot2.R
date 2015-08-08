# creates plot 2: plot of Global Active Power
# -------------------------------------------------

# loads the data
tab <- loadHouseholdPowerConsumptionData()

# opens graphic device
png(file = "plot2.png", width = 480, height = 480)

# creates plot
plot(tab$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab = "", xaxt = "n")
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