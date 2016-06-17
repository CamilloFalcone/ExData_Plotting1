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



#######
SecondPlot <-function(){
png("plot2.png")
wd<-getwd()
df<-Read_Data()
NumRow<- dim(df)[1]
plot(df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", axes=FALSE, xlab="") #this is the second..change the x axis labels
atx<-c(0, NumRow/2,NumRow)
labx= c("Thu", "Fri", "Sat")
aty<- seq(0, 6, 2)
laby <- seq(0, 6, 2)
axis (1, atx, labx)
axis (2, aty, laby)
box()
dev.off()
setwd(wd)
}


