# Eduardo Ferreira

# Loading provided datasets - loading from local machine
NEI <- readRDS("/home/cadu/Desktop/Coursera/Exploratory_Data_Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/cadu/Desktop/Coursera/Exploratory_Data_Analysis/data/Source_Classification_Code.rds")

# creating a Sampling and subset with data
NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]
MD <- subset(NEI, fips=='24510')

png(filename='/home/cadu/Desktop/Coursera/datasciencecoursera/Exploratory_data_analysis/plot2.png')

barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()