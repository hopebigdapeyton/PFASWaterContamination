# Data cleaning


# setup
# install.packages("tidyverse")

library(tidyverse)
library(readr)

# rm(MPART_Original_Unique_Values)
mydata <- read_csv("mydata_v2.csv", na = c("", "NA"))

names(mydata)[1] <- "COUNTYNAME"
names(mydata)

names(mydata)[25] <- "TOTALPFAS"

p <- ggplot(data = mydata, mapping = aes(x = TOTALPFAS, y = COUNTYNAME))
p + geom_point(color = "purple") + geom_smooth(method = "loess") + scale_x_log10() + labs (x = "Parts per Trillion", y = "Michigan Counties", title = "PFAS Concentration Levels in Michigan Counties", subtitle = "data points are calculated total PFAS", caption = "Source: Michigan PFAS Response.")

p <- ggplot(data = mydata, mapping = aes(x = TOTALPFAS, y = COUNTYNAME))
p + geom_point(color = "purple") + geom_smooth(method = "loess") + scale_x_sqrt() + labs (x = "Parts per Trillion", y = "Michigan Counties", title = "PFAS Concentration Levels in Michigan Counties", subtitle = "data points are calculated total PFAS", caption = "Source: Michigan PFAS Response.")

install.packages("devtools")
library(devtools)

#Data Tests
mydata <- read_csv("mydata_v2.csv")

p <- ggplot(data = mydata, mapping = aes(x = PFOA, y = COUNTYNAME))
p + geom_point(color = "purple") + geom_smooth(method = "loess") + scale_x_sqrt() + labs (x = "Parts per Trillion", y = "Michigan Counties", title = "PFOA Concentration Levels in Michigan Counties", subtitle = "data points are only PFOA", caption = "Source: Michigan PFAS Response.")

p <- ggplot(data = mydata, mapping = aes(x = PFBS, y = COUNTYNAME))
p + geom_point(color = "purple") + geom_smooth(method = "loess") + scale_x_sqrt() + labs (x = "Parts per Trillion", y = "Michigan Counties", title = "PFBS Concentration Levels in Michigan Counties", subtitle = "data points are only PFBS", caption = "Source: Michigan PFAS Response.")

p <- ggplot(data = mydata, mapping = aes(x = PFBS, y = "Calculated Total PFAS"))
