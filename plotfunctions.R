library(data.table)

# 데이터를 읽을 때 결측치(?)를 NA로 처리
data <- fread("household_power_consumption.txt", na.strings = "?")

# Date 2007-02-01 ~ 2007-02-02
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

date_time <- as.POSIXct(paste(sub_data$Date, sub_data$Time))
Sys.setlocale("LC_TIME", "C")
axis_ticks <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
axis_labels <- format(axis_ticks, "%a")

plot1 <- function(...){
        # Open PNG 480x480
        png("plot1.png", width=480, height=480)

        # Draw histogram
        hist(sub_data$Global_active_power, 
                col = "red", 
                main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)")
        # save
        dev.off()
        }
plot2 <- function(...){        
        # 3. Open PNG 480x480
        png("plot2.png", width=480, height=480)
        
        # 4. line plot (type="l")
        plot(date_time, sub_data$Global_active_power, 
             type="l", 
             xlab="", 
             ylab="Global Active Power (kilowatts)",
             xaxt="n"
             )
        axis(1, at=axis_ticks, labels=axis_labels)
        

        dev.off()
}
plot3 <- function(...){
        # PNG
        png("plot3.png", width=480, height=480)
        
        # 1. draw black line
        plot(date_time, sub_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        # 2. draw red line
        lines(date_time, sub_data$Sub_metering_2, col="red")
        # 3. draw blue line
        lines(date_time, sub_data$Sub_metering_3, col="blue")
        
        # Legend
        legend("topright", 
               col=c("black", "red", "blue"), 
               lty=1, 
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        dev.off()
}
plot4 <- function(...){
        # PNG 
        png("plot4.png", width=480, height=480)
        
        par(mfrow = c(2, 2))
        
        # 1. Global Active Power
        plot(date_time, sub_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        
        # 2. Voltage vs Time
        plot(date_time, sub_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        # 3. Sub metering
        plot(date_time, sub_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(date_time, sub_data$Sub_metering_2, col="red")
        lines(date_time, sub_data$Sub_metering_3, col="blue")
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        # 4. Global Reactive Power vs Time
        plot(date_time, sub_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        dev.off()
}