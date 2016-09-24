#set your working directory here#
setwd("/Users/aymaneldahrawy/Documents/Coursera/Exploratory data analysis assignment")
#read the files#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Question 1#
NEI_1999 <- subset(NEI,NEI$year==1999)
NEI_2002 <- subset(NEI,NEI$year==2002)
NEI_2005 <- subset(NEI,NEI$year==2005)
NEI_2008 <- subset(NEI,NEI$year==2008)

sum_1999 <- sum(NEI_1999$Emissions)
sum_2002 <- sum(NEI_2002$Emissions)
sum_2005 <- sum(NEI_2005$Emissions)
sum_2008 <- sum(NEI_2008$Emissions)
x <- c(1999,2002,2005,2008)
y <- c(sum_1999,sum_2002,sum_2005,sum_2008)/1000000

rng <- range(y)

png(file="plot1.png")
plot(x,y,ylim = c(0,rng[2]+.5))
title(main = "Total emissions (millions of tons)", xlab = "year" )
dev.off()