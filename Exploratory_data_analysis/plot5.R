# Eduardo Ferreira

# Loading data
NEI <- readRDS("/home/cadu/Desktop/Coursera/Exploratory_Data_Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/cadu/Desktop/Coursera/Exploratory_Data_Analysis/data/Source_Classification_Code.rds")

# generating data and aggregating
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# need ggplot2 library
library(ggplot2)e
png('/home/cadu/Desktop/Coursera/datasciencecoursera/Exploratory_data_analysis/plot5.png')

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()