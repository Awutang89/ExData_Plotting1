plot4 <- function (url){
        #downloads the data to your hard drive and puts it in a folder called data.
        if (!file.exists("./data")) {dir.create("./data")}
        download.file(url, destfile = "./data/epc.zip")
        unzip("./data/epc.zip")
        
        #read the data from those specific two days
        rawdata <-read.table("household_power_consumption.txt", sep = ";", skip = 1, na.strings = "?" , col.names = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","submetering1","submetering2","submetering3"))
        rawdata1 <- subset(rawdata, date %in% c("1/2/2007","2/2/2007"))
        
        #create chronological order for time
        datetime <- strptime(paste(rawdata1$date, rawdata1$time, sep=" "), "%d/%m/%Y %H:%M:%S")
        
        #give it to the overall data set
        rawdata1 <- cbind(rawdata1, datetime)
        
        png(filename = "plot4.png", width = 480, height = 480)
        par(mfrow = c(2,2))  #setup two rows and two columns
        with(rawdata1, plot(datetime,global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))  #top left graph
        with(rawdata1, plot(datetime,voltage, type = "l", ylab = "Voltage", xlab = "datetime"))  #top right graph
        with(rawdata1, plot(datetime,rawdata1$submetering1, type = "l", ylab = "Energy Sub Metering", xlab = ""))  #bottom right graph
        lines(rawdata1$datetime, rawdata1$submetering2, type = "l", col = "red")
        lines(rawdata1$datetime, rawdata1$submetering3, type = "l", col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1 , bty = "n")
        with(rawdata1, plot(datetime,global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
        dev.off()
       
        
        
}