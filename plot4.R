## JHU Exploratory Data Analysis
# Course Project 2
# Code for creating Plot 4
# Created by Callen Hyland, March 7, 2022

## Question 4: 
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008? (Can use any plotting system)

library(dplyr)
library(ggplot2)

# Read data set
NEI <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# Get codes for everything related to coal burning
coal.codes <- codes$SCC[grepl("Coal", codes$EI.Sector, ignore.case = TRUE)]
coal.em <- filter(NEI, is.element(NEI$SCC, coal.codes))

rm(NEI, codes) # remove large datasets

# Group by year and find sum of emissions
Total.Em <- coal.em %>%
  group_by(year) %>% 
  summarize(sumEm = sum(Emissions))

# Make plot
png("plot4.png", width = 400, height = 300)

ggplot(data = Total.Em, aes(x = year, y = sumEm)) +
  geom_line(color = "blue") +
  xlab("Year") + ylab("Emissions (tons)") + 
  ggtitle("Total emissions from coal (1999-2008)") +
  theme(axis.text = element_text(size = 14), 
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16))

dev.off()

