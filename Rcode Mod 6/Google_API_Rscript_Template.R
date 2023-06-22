#Install the relevant libraries - do this one time
#install.packages("lubridate")
#install.packages("ggplot2")
#install.packages("data.table")
#install.packages("ggrepel")
#install.packages("dplyr")
#install.packages("tidyverse")
#install.packages("ggsn")

# Load the relevant libraries - do this every time
library(rtools40)
library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(ggrepel)
library(tidyverse)
library(ggsn)

#A) Download the main crime incident dataset
POI= read.csv('C:\\Users\\lacey\\Desktop\\Utica College Stuff\\DSC 611\\Module Six\\Point_Of_Interest.csv', header=T)

# Look at the data sets
dim(POI)
head(POI)

#More Q&A - https://github.com/dkahle/ggmap/issues/51
#Get the latest Install


library(ggmap)

#Set your API Key ~ put your key beteen the quotations marks
ggmap::register_google(key ="AIzaSyDvy2P8vDvBMHZHhH-FqUZBOnMiY6aa8v4")


brooklynCenter <- c(lon = -73.9442, lat = 40.6782)
brooklynMap <- ggmap(get_googlemap(brooklynCenter, maptype = "roadmap", zoom=15))
brooklynMap + 
  geom_point(aes(x = POI$LON, y = POI$LAT),show.legend = TRUE,data = POI, size = 1.0, color="orange") +
  north2(brooklynMap,.9, .5, symbol = 10) +
  scalebar(POI,x.min = -40.64, x.max = -40.66,y.min = 73.45, y.max = 73.97, dist = 4, 
           dist_unit = "km",transform = TRUE, model = "WGS84", box.fill = c("black", "white"), box.color = "black", border.size = 1)
  

statenIslandCenter <- c(lon = -74.1502, lat = 40.5795)
statenIslandMap <- ggmap(get_googlemap(statenIslandCenter, maptype = "satellite", zoom=12))
statenIslandMap + 
  geom_point(aes(x = POI$LON, y = POI$LAT),show.legend = TRUE,data = POI, size = 1.0, color="blue") +
  north2(statenIslandMap,.9, .5, symbol = 8) +
  scalebar(POI,x.min = -40.64, x.max = -40.66,y.min = 73.45, y.max = 73.97, dist = 4, 
           dist_unit = "km",transform = TRUE, model = "WGS84", box.fill = c("black", "white"), box.color = "black", border.size = 1)



