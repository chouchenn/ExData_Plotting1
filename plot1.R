# creates plot 1: histogram of Global Active Power
# -------------------------------------------------

# loads the data
tab <- loadHouseholdPowerConsumptionData()

# opens graphic device
png(file = "plot1.png", width = 480, height = 480)

# creates histogram
hist(tab$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

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