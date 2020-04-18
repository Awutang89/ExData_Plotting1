plot1 <- function (url){
        #downloads the data to your hard drive and puts it in a folder called data.
        if (!file.exists("./data")) {dir.create("./data")}
        download.file(url, destfile = "./data/epc.zip")
        unzip("./data/epc.zip")

        #read the data from those specific two days
        rawdata <-read.table("household_power_consumption.txt", sep = ";", skip = 1, na.strings = "?" , col.names = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","submetering1","submetering2","submetering3"))
        rawdata1 <- subset(rawdata, date %in% c("1/2/2007","2/2/2007"))
        rawdata1 <- mutate(rawdata1, date = as_date(dmy(date))) #changes the dates to date format in r
        rawdata1 <- mutate(rawdata1, time = hms(time)) #changes the time to time format in r
        
        png(filename = "plot1.png", width = 480, height = 480)
        hist(rawdata1$global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts")
        dev.off()
        
        
        }