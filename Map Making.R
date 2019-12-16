#don't think I actually used all these packages.. go through and eliminate the ones I didn't use
#reference: https://eriqande.github.io/rep-res-eeb-2017/map-making-in-R.html#ggmap-hooray

# setup
# install.packages("tidyverse")
install.packages("sf")
install.packages("ggplot2")
install.packages("devtools")
install.packages("dplyr")
install.packages("stringr")
install.packages("maps")
install.packages("mapdata")
install.packages("dplyr")
my_packages <- c("tidyverse", "broom", "coefplot", "cowplot",
                 "gapminder", "GGally", "ggrepel", "ggridges", "gridExtra",
                 "here", "interplot", "margins", "maps", "mapproj",
                 "mapdata", "MASS", "quantreg", "rlang", "scales",
                 "survey", "srvyr", "viridis", "viridisLite", "devtools")
install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
install.packages(c("maps", "mapdata"))
devtools::install_github("dkahle/ggmap")
install.packages(c("maps", "mapdata"))
install_github("dkahle/ggmap")
install.packages(my_packages, repos = "http://cran.rstudio.com")

#install libraries
library(stringr)
library(viridis)
library(tidyverse)
library(readr)
library(sf)
library(maps)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(mapproj)

#create base layer map with Michigan county outlines
states <- map_data("state")
dim(states)
head(states)
tail(states)    
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)  # do this to leave off the color legend
michigan <- subset(states, region %in% c("michigan"))
ggplot(data = michigan) + 
  geom_polygon(aes(x = long, y = lat), fill = "palegreen", color = "black") 
ggplot(data = michigan) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)
mi_df <- subset(states, region == "michigan")
head(mi_df)     
tail(mi_df)
counties <- map_data("county")
mi_county <- subset(counties, region == "michigan")
mi_base <- ggplot(data = mi_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
mi_base + theme_void()
mi_base + theme_void() + 
  geom_polygon(data = mi_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA)  # get the state border back on top
mi_base_county <- mi_base + theme_void() + 
  geom_polygon(data = mi_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA)  # save as integrated base layer

#merge data frames to add on PFAS data layer
#MI base layer map includes county-level data, but needed to go back to PFAS data to change capitalization of county-level data before could merge
merge(counties, GEOCODE_MERGE_2, by.x = "subregion", by.y = "subregion")
mipfas <- merge(counties, GEOCODE_MERGE_2, by.x = "subregion", by.y = "subregion")
PFAS_Concentration <- mi_base_county +
  geom_polygon(data = mipfas, aes(fill = Calculated.Total.PFAS), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()
PFAS_Concentration #wow! this is an ugly map but it seems to have worked

# Overwrite given size 
PFAS_Concentration + theme(legend.title = element_text(color = "blue", size = "2"),
                           legend.text = element_text(color = "red", size = 1), (guide_legend = size = 2))

#zoom
PFAS_Concentration + coord_quickmap(xlim = c(-90, -80),  ylim = c(40, 50)) + labs(title = "Michigan County-Level Total PFAS Contamination")

#Result = Final Calculated Total PFAS

#Re-run for Total PFHxS
PFAS_Concentration2 <- mi_base_county +
  geom_polygon(data = mipfas, aes(fill = PFHxS), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()
PFAS_Concentration2
PFAS_Concentration2 <- mi_base_county +
  geom_polygon(data = mipfas, aes(fill = PFHxS), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()
PFAS_Concentration2


PFAS_Concentration2 <- mi_base_county +
  geom_polygon(data = mipfas, aes(fill = PFHxS), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()
PFAS_Concentration2

#zoom
PFAS_Concentration2 + coord_quickmap(xlim = c(-90, -80),  ylim = c(40, 50)) + labs(title = "Michigan County-Level PFHxS Contamination")




