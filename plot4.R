library(data.table)

data <- fread("household_power_consumption.txt", na.strings = "?")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

date_time <- as.POSIXct(paste(sub_data$Date, sub_data$Time))
Sys.setlocale("LC_TIME", "C")
axis_ticks <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
axis_labels <- format(axis_ticks, "%a")

# PNG 
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))

# 1. Global Active Power
plot(date_time, sub_data$Global_active_power, type="l", xlab="", ylab="Global Active Power", xaxt="n")
axis(1, at=axis_ticks, labels=axis_labels)

# 2. Voltage vs Time
plot(date_time, sub_data$Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, at=axis_ticks, labels=axis_labels)

# 3. Sub metering
plot(date_time, sub_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",
     xaxt="n")
axis(1, at=axis_ticks, labels=axis_labels)
lines(date_time, sub_data$Sub_metering_2, col="red")
lines(date_time, sub_data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4. Global Reactive Power vs Time
plot(date_time, sub_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", xaxt="n")
axis(1, at=axis_ticks, labels=axis_labels)

dev.off()