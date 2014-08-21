# Eduardo Ferreira
# Loading data 
NEI <- readRDS("/home/cadu/Desktop/Coursera/Exploratory_Data_Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/cadu/Desktop/Coursera/Exploratory_Data_Analysis/data/Source_Classification_Code.rds")

# Sampling and aggregating
NEI_sampling <- NEI[sample(nrow(NEI), size=2000, replace=F), ]
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

# Generating the graph 
png(filename='/home/cadu/Desktop/Coursera/datasciencecoursera/Exploratory_data_analysis/plot1.png')

barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()