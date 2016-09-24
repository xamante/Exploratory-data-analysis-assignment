#set your working directory here#
setwd("/Users/aymaneldahrawy/Documents/Coursera/Exploratory data analysis assignment")
#read the files#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Question 2
balt_1999 <- subset(NEI_1999,NEI$fips=="24510")
balt_2008 <- subset(NEI_2008,NEI$fips=="24510")
sum_balt_1999 <- sum(balt_1999$Emissions,na.rm = TRUE)
sum_balt_2008 <- sum(balt_2008$Emissions,na.rm = TRUE)
x <- c(1999,2008)
y <- c(sum_balt_1999,sum_balt_2008)/1000000
png(file="plot2.png")
plot(x,y)
title(main = "Total emissions (millions of tons) in Baltimore", xlab = "year" )
dev.off()