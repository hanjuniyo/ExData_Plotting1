library(data.table)

data <- fread("household_power_consumption.txt", na.strings = "?")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

date_time <- as.POSIXct(paste(sub_data$Date, sub_data$Time))
Sys.setlocale("LC_TIME", "C")
axis_ticks <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
axis_labels <- format(axis_ticks, "%a")

# PNG 480x480
png("plot2.png", width=480, height=480)

# line plot (type="l")
plot(date_time, sub_data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)",
     xaxt="n"
)
axis(1, at=axis_ticks, labels=axis_labels)
dev.off()