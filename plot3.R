## JHU Exploratory Data Analysis
# Course Project 2
# Code for creating Plot 3
# Created by Callen Hyland, March 5, 2022

## Question 3: 
# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases
# in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

# Read data set
NEI <- readRDS("summarySCC_PM25.rds")

# Filter to get just records from Baltimore
balt <- filter(NEI, fips == "24510")
rm(NEI) # remove large dataset

# Group by year and find sum of each year
Total.Em <- balt %>%
  group_by(year, type) %>% 
  summarize(sumEm = sum(Emissions))

# Make plots
png("plot3.png", width = 600, height = 480)

# single plot, multiple lines
ggplot(data = Total.Em, aes(x = year, y = sumEm)) +
  geom_line(aes(color = type)) +
  xlab("Year") + ylab("Emissions (tons)") + 
  ggtitle("Emissions in Baltimore City (1999-2008)") +
  theme(axis.text = element_text(size = 14), 
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16))

dev.off()
