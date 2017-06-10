library(dplyr)
library(lubridate)

power <- read.table("household_power_consumption.txt", sep = ";", 
                    header = TRUE, 
                    stringsAsFactors = FALSE, 
                    colClasses = "character")

power <- power %>% mutate(Date = as.Date(Date, '%d/%m/%Y'))

startDate <- as.Date("2007-02-01", "%Y-%m-%d")
endDate <- as.Date("2007-02-02", "%Y-%m-%d")

targetPower <- power %>% filter(Date >= startDate & Date <= endDate)

targetPower <- targetPower %>% mutate(Time = paste(Date, Time))

targetPower <- targetPower %>% mutate(Time = ymd_hms(Time),
                                      Global_active_power = as.numeric(Global_active_power),
                                      Global_reactive_power = as.numeric(Global_reactive_power),
                                      Sub_metering_1 = as.numeric(Sub_metering_1),
                                      Sub_metering_2 = as.numeric(Sub_metering_2),
                                      Sub_metering_3 = as.numeric(Sub_metering_3),
                                      Voltage = as.numeric(Voltage))

#Now we're beginning drawing...

png("plot4.png",width = 480, height = 480)
par(mfrow = c(2, 2))

with(targetPower, plot(Time, 
                       Global_active_power, 
                       type = "l", 
                       ylab = "Global Active Power", 
                       xlab = ""))

with(targetPower, plot(Time, 
                       Voltage, 
                       type = "l", 
                       ylab = "Voltage", 
                       xlab = "datetime"))

plot(targetPower$Time, 
     targetPower$Sub_metering_1, 
     type = "n", 
     xlab = "",
     ylab = "Energy sub metering")

lines(targetPower$Time, targetPower$Sub_metering_1, col = "black")
lines(targetPower$Time, targetPower$Sub_metering_2, col = "red")
lines(targetPower$Time, targetPower$Sub_metering_3, col = "blue")

legend('topright', 
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lty = 1,
       bty = "n",
       col = c('black', 'red', 'blue'))

with(targetPower, plot(Time, 
                       Global_reactive_power, 
                       type = "l", 
                       xlab = "datetime"))

dev.off()



