PWD<-getwd()
setwd(PWD)

library(ggplot2)                                                       #library to plot included
library(prospectr)                                                     #library of filters

inp=read.table("SCONES_test.tsv")                                      #reading input

inp$ratio <- as.numeric(inp$V4)/as.numeric(inp$V5)                     #calculation of ratio
inp$log_ratio <- log(inp$ratio)                                        #calculation of log of ratio


inp$average_filtered <- c(0,0,0,movav(inp$log_ratio,w=7),0,0,0)        #moving average filter

inp$savitzky <- c(0,0,0,savitzkyGolay(inp$log_ratio,p=5,w=7,m=0),0,0,0)#Savitzky Golay filter

inp$both <- c(0,0,0,movav(inp$savitzky,w=7),0,0,0)                     #application of moving average filter after Savitzky Golay filter

inp$averaged_twice <- c(0,0,0,movav(inp$average_filtered,w=7),0,0,0)   #application of moving average filter twice

p1 <- ggplot(data=inp, aes(x=V3,y=averaged_twice,group=1))
p1 + geom_line(stat="identity")+ geom_line(aes(x=V3,y=log_ratio,group=1),stat="identity",color="red",alpha=0.4)
#plotting the results of double application of moving average filter with respect to initial logRatio signal


p1 <- ggplot(data=inp, aes(x=V3,y=both,group=1))
p1 + geom_line(stat="identity")+ geom_line(aes(x=V3,y=log_ratio,group=1),stat="identity",color="red",alpha=0.4)
#plotting the results of application of both the filters with respect to initial logRatio signal

p1 <- ggplot(data=inp, aes(x=V3,y=savitzky,group=1))
p1 + geom_line(stat="identity")+ geom_line(aes(x=V3,y=log_ratio,group=1),stat="identity",color="red",alpha=0.4)
#plotting the results of application of Savitzky Golay filter with respect to initial logRatio signal

p1 <- ggplot(data=inp, aes(x=V3,y=average_filtered,group=1))
p1 + geom_line(stat="identity")+ geom_line(aes(x=V3,y=log_ratio,group=1),stat="identity",color="red",alpha=0.4)
#plotting the results of application of moving average filter with respect to initial logRatio signal
