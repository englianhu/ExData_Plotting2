## Download raw zipped data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile <- "NEI_data.zip"
download.file(fileUrl, destfile=paste("data", destfile, sep="/"))

## Unzip the dataset
unzip(paste("data", destfile, sep="/"), exdir="data")
data_dir <- setdiff(dir("data"), destfile)

# Read dataset
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subset data
BC <- subset(NEI, fips=='24510')

# Plot graph
png(filename='plot2.png')
barplot(tapply(X=BC$Emissions, INDEX=BC$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))
dev.off()
