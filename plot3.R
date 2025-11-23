library(data.table)

data <- fread("household_power_consumption.txt", na.strings = "?")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

date_time <- as.POSIXct(paste(sub_data$Date, sub_data$Time))
Sys.setlocale("LC_TIME", "C")
axis_ticks <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
axis_labels <- format(axis_ticks, "%a")

# PNG
png("plot3.png", width=480, height=480)

# 1. draw black line
plot(date_time, sub_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n")
# 2. draw red line
lines(date_time, sub_data$Sub_metering_2, col="red")
# 3. draw blue line
lines(date_time, sub_data$Sub_metering_3, col="blue")

#Thu, Fri, Sat
axis(1, at=axis_ticks, labels=axis_labels)

# Legend
legend("topright", 
       col=c("black", "red", "blue"), 
       lty=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
