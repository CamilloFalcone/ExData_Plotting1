Read_Data<- function() {
datapath<-"/Users/camillof/Data/"
setwd(datapath)
df1 <- read.csv ("household_power_consumption.txt", sep=";", nrow=1)
command <- "egrep -w '1/2/2007|2/2/2007' household_power_consumption.txt > hpc.txt" #produces the file with the subset with the row required
system(command) # run the egrp command
#redefine the names of the columns in df according to df1
df<-read.csv("hpc.txt",sep=";") 
colnames(df)<- names(df1)
df$Date<-as.Date(df$Date, format="%d/%m/%Y")
df$Time<-strptime(df$Time, format="%H:%M:%S")
df <- cbind(df, weekdays(df$Date)) #add a column with the name of the week

return(df)
}


#######this is the third plot
ThirdPlot <- function() {
png("plot3.png")
wd<-getwd()
df<-Read_Data()
NumRow<- dim(df)[1]
plot(df$Sub_metering_1, axes=FALSE, xlab="", ylab="Energy sub metering",type="l")
lines(df$Sub_metering_2, col="red")
lines(df$Sub_metering_3, col="blue")
atx<-c(0, NumRow/2,NumRow)
labx= c("Thu", "Fri", "Sat")
aty<- seq(0, 30, 10)
laby <- seq(0, 30, 10)
axis (1, atx, labx)
axis (2, aty, laby)
box()
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
setwd(wd)
}
