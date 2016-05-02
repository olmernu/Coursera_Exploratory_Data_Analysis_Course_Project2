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
#Question 5
#How have emissions from motor vehicle sources changed from 1999-2008 in 
#Baltimore City?

# merge the two data sets 
NEISCC <- merge(NEI, SCC, by="SCC")

# 24510 is Baltimore
# Searching for ON-ROAD type in NEI
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

#Making the plot with ggplot2 plotting system
library("ggplot2")

png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City, Maryland from 1999 to 2008')
print(g)
dev.off()