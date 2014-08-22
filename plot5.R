# Load package
library(ggplot2)

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

# Subset dataset
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))
BC.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
BC.df <- aggregate(BC.onroad[, 'Emissions'], by=list(BC.onroad$year), sum)
colnames(BC.df) <- c('year', 'Emissions')

# Plot graph
png('plot5.png')
ggplot(data=BC.df, aes(x=year, y=Emissions)) + geom_bar(stat="identity", aes(fill=year)) +
       guides(fill=F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
       ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
       geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))
dev.off()
