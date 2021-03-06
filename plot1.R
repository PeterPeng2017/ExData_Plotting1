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

png("plot1.png",width = 480, height = 480)
par(mfrow = c(1, 1))

hist(targetPower$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()


