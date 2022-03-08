## JHU Exploratory Data Analysis
# Course Project 2
# Code for creating Plot 5
# Created by Callen Hyland, March 7, 2022

## Question 5: 
# How have emissions from motor vehicle sources changed from 1999–2008
# in Baltimore City? (Can use any plotting system)

library(dplyr)
library(ggplot2)

# Read data set
NEI <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# get motor vehicle codes
mv.codes <- codes$SCC[grepl("Vehicle", codes$EI.Sector, ignore.case = TRUE)]

# Filter to get just Vehicle records from Baltimore
balt.mv <- filter(NEI, fips == "24510" & is.element(NEI$SCC, mv.codes))
rm(NEI, codes) # remove large datasets

# Group by year and find sum of emissions
Total.Em <- balt.mv %>%
  group_by(year) %>% 
  summarize(sumEm = sum(Emissions))

# Make plot
png("plot5.png", width = 450, height = 350)

ggplot(data = Total.Em, aes(x = year, y = sumEm)) +
  geom_line(color = "blue") +
  xlab("Year") + ylab("Emissions (tons)") + 
  ggtitle("Total vehicle emissions in Baltimore (1999-2008)") +
  theme(axis.text = element_text(size = 14), 
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16))

dev.off()
