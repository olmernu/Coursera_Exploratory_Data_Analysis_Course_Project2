################################################################
##
## Exploratory Data Analysis
## Course Project 2
## Olmer Nunez-Sosa
## 2016-04-30
##
################################################################

################################################################
# Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

################################################################
#Question 4
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999-2008?

NEISCC <- merge(NEI, SCC, by="SCC")
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]
head(subsetNEISCC)
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)


#Making the plot with ggplot2 plotting system
library("ggplot2")

png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()