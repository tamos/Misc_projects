
# Drone data code

library(readr)

PakistanDroneAttacks <- read_csv("F:/Work/Datasets/pakistandroneattacks/PakistanDroneAttacks.csv", na = "NA")
#PakistanDroneAttacks$dayofweek <- 

days <- PakistanDroneAttacks$Date

library(stringr)

d <- str_split_fixed(days, ", ", 3)
f <- str_split_fixed(d[,2], " ", 2)
d <- cbind(d,f)
rm(f)
d <- d[,-2]
days <- d
rm(d)
PakistanDroneAttacks <- cbind(PakistanDroneAttacks, days)
rm(days)
PakistanDroneAttacks <- PakistanDroneAttacks[,-2]
colnames(PakistanDroneAttacks)[22:25] <- c("day", "year", "month", "date")
colnames(PakistanDroneAttacks)[1] <- c("attackid")
colnames(PakistanDroneAttacks) <- gsub(" ", "_", colnames(PakistanDroneAttacks))
PakistanDroneAttacks <- PakistanDroneAttacks[-398, ]

library(ggplot2)
library(plyr)
library(stats)

byyr <- data.frame(table(PakistanDroneAttacks$year))
byyr1 <- data.frame(xtabs(PakistanDroneAttacks$Total_Died_Min ~ PakistanDroneAttacks$year))
colnames(byyr1) <- c("year", "Total_Died_Min")
byyr <- cbind(byyr, byyr1[,2])
byyr1 <- data.frame(xtabs(PakistanDroneAttacks$Total_Died_Mix ~ PakistanDroneAttacks$year))
colnames(byyr1) <- c("year", "Total_Died_Max")
byyr <- cbind(byyr, byyr1[,2])
rm(byyr1)
colnames(byyr) <- c("year", "total_strikes", "min_fatalities", "max_fatalities")
byyr <- byyr[-1,]



ggplot(byyr, aes(x = year)) +
geom_line(aes(y = total_strikes)) 
  #geom_col(aes(y = total_strikes, color = "total_strikes")) 
  geom_line(aes(y = max_fatalities))

ggplot(PakistanDroneAttacks, aes(x = year)) +
  geom_col(aes(y = count(attackid)))


ggplot(PakistanDroneAttacks[!(PakistanDroneAttacks$year == ""),], aes(year, (attackid / attackid))) +
  geom_col() 


  # geom_boxplot(aes(x = year, y = Total_Died_Min)) 
  # geom_boxplot(aes(x = year, y = Total_Died_Mix)) 
  

plot(byyr$max_fatalities ~ byyr$year, par(type = "h")) 

levels(as.factor(PakistanDroneAttacks$Province))

PakistanDroneAttacks$Province <- as.factor(PakistanDroneAttacks$Province)
levels(PakistanDroneAttacks$Province)[2] <- levels(PakistanDroneAttacks$Province)[3] 
levels(PakistanDroneAttacks$Province)


# heat map
ggplot(PakistanDroneAttacks, aes(x = year, y = Province)) +
  geom_bin2d()



y = c("total_strikes", "min_fatalities", "max_fatalities")))


p

geom_bar(data = byyr,aes(x = Var1, y = Freq), na.rm = TRUE)

plot(byyr)


install.packages("ggmap", dependencies = TRUE)
install.packages("maptools", dependencies = TRUE)
install.packages("mapdata", dependencies = TRUE)
install.packages("scales", dependencies = TRUE)

library(ggmap)
library(maps)
library(mapproj)
library(maptools)
library(mapdata)
library(scales)



map(database = "world", regions = "Pakistan", col = 24, fill = TRUE)
points(PakistanDroneAttacks$Longitude, PakistanDroneAttacks$Latitude, col = "blue", pch = 19)
# should try with gganimate package

devtools::install_github("dgrtwo/gganimate")

map(database = "world", regions = "Pakistan", col = 24, fill = TRUE)
points(PakistanDroneAttacks$Longitude, PakistanDroneAttacks$Latitude, col = "blue", pch = 19)

#try to subset by year
#map(database = "world", regions = "Pakistan", col = 24, fill = TRUE)
#points(PakistanDroneAttacks$Longitude[year == "2008", "Longitude"], PakistanDroneAttacks$Latitude[(PakistanDroneAttacks$year == "2008"), "Latitude"], col = "blue", pch = 19)

latlon2 <- PakistanDroneAttacks$Latitude[PakistanDroneAttacks$year == "2008", ]

PakistanDroneAttacks[PakistanDroneAttacks$year == "2008", ]


latlon <- data.frame(PakistanDroneAttacks[,20:21])
latlon2 <- mapproject(x = latlon[,1], y = latlon[,2])

plot(latlon2)

map.cities(x = world.cities, country = "Pakistan", label = FALSE, minpop = 10000)

latlon <- data.frame(PakistanDroneAttacks[,20:21])

map.where(database = "world", x = latlon[,1], y = latlon[,2])

plot(PakistanDroneAttacks$Longitude ~ PakistanDroneAttacks$Latitude)

class(PakistanDroneAttacks$`Total Died Min`)
     
table(PakistanDroneAttacks$year ~ PakistanDroneAttacks$`Total Died Min`)

plot(count(as.factor(PakistanDroneAttacks$attackid)) ~ as.factor(PakistanDroneAttacks$year))

ggplot(PakistanDroneAttacks) +
  aes(x = year, y = PakistanDroneAttacks[,12]) +
  geom_col() +
  geom_col(aes(y = PakistanDroneAttacks$Civilians_Min))



)
+ aes(y = count(year)))
       
         

