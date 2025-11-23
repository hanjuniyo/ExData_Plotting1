library(data.table)

data <- fread("household_power_consumption.txt", na.strings = "?")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Open PNG 480x480
png("plot1.png", width=480, height=480)

# Draw histogram
hist(sub_data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
# save
dev.off()