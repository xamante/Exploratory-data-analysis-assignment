#set your working directory here#
setwd("/Users/aymaneldahrawy/Documents/Coursera/Exploratory data analysis assignment")
#read the files#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Question 4

str(SCC)
#identify which column holds the combustion-related sources
for (i in (1:length(SCC))){
  x[i] <- sum(grepl(SCC[,i],pattern = "coal"))
}
which(x>1)
#inspect the 2 possible columns containing the label 
SCC$Short.Name[which(grepl(SCC$Short.Name,pattern = "coal")==TRUE)]
SCC$SCC.Level.Three[which(grepl(SCC$SCC.Level.Three,pattern = "coal")==TRUE)]
SCC$coal <- grepl(SCC$Short.Name,pattern = "coal",ignore.case = TRUE)
(SCC$Short.Name[which(coal==TRUE)])
sub_SCC <- subset(SCC,coal==TRUE)
sum(sub_SCC$coal)
#merge data with NEI dataframe
png(file="plot4.png")
merged_data <- merge(NEI,sub_SCC,by = "SCC")
sub_merged <- subset(merged_data,coal==TRUE)
total_coal_emissions <- tapply(sub_merged$Emissions,sub_merged$year,sum)
barplot(total_coal_emissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from coal sources")
dev.off()