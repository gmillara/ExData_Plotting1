## the 'read_power' function reproduced to get 4 plot*.R files as
## per the assignment

###########################################################################
# 'read-power' returns the appropriate subsetted data frame with 
# conversions to the 'Date' and 'Time' columns

read_power <- function() {
  data_file <- "household_power_consumption.txt"
  
  colClasses <-  c("character","character", "numeric","numeric","numeric",
                   "numeric","numeric","numeric","numeric")
  
  power <- read.table(data_file,header=TRUE,sep=";",na.strings="?",
                      colClasses=colClasses)
  ## Convert 'Date' charcter to Date class
  power[[1]] <- as.Date(power[[1]],format="%d/%m/%Y")
  
  ## Subsetting power to obtain data from 2007-02-01 and 2007-02-02
  
  power <- power[ (power[[1]] == as.Date("2007-02-01")) | 
                    (power [[1]] == as.Date("2007-02-02")) , ]
  
  ## Converting 'Time' colum to POSIXlt class
  power[[2]] <- strptime(paste(power[[1]],power[[2]], sep =" "),
                         format = "%Y-%m-%d %H:%M:%S")
  power
  
}

##########################################################################

# subsetted data frame from file 
power <- read_power()

# Opens png Device
png(file="plot3.png",width = 480, height = 480)

# Empty plot
with(power,plot(y=Sub_metering_1,x=Time,ylab=
                  "Energy sub metering",xlab="",type="n"))
# Adds colored lines
with(power,lines(Time,Sub_metering_1,col="black" ) ) 
with(power,lines(Time,Sub_metering_2,col="red"  ) )
with(power,lines(Time,Sub_metering_3,col="blue" ) )

# Adds legend
legend("topright",col=c("black","red","blue"),lty=c(1,1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Closes Device
dev.off()

##########################################################################