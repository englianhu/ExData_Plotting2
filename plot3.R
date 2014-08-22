## Load package
require(ggplot2)

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

# Baltimore City, Maryland == fips
BC <- subset(NEI, fips == 24510)
BC$year <- factor(BC$year, levels=c('1999', '2002', '2005', '2008'))

# Plot graph
png(filename='plot3.png', width=800, height=500, units='px')
ggplot(data=BC, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
    geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
    ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
    ggtitle('Emissions per Type in Baltimore City, Maryland') +
    geom_jitter(alpha=0.10)
dev.off()
