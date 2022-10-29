###### Installing the ggplot2 library / package

install.packages("ggplot2")

library(ggplot2)

# ecological dataframe
# biofuels
biofuels <- c(120, 200, 350, 570, 750) # array of values: c
biofuels
# oxydative enzimes
oxydative <- c(1200, 1300, 21000, 34000, 50000) 

# dataframe
d <- data.frame(biofuels, oxydative)
d

# Is it the same to do data.frame(biofuels,oxydative)? yes!
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point()

ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point(size = 5, col = "red")

# lines
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_line() 

# points + lines
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point(size = 5, col = "red")  +  geom_line() 

# polygons
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_polygon()

############## IMPORT DATA FROM AN EXTERNAL SOURCE

# setwd("path/lab")

# setwd for Windows
# setwd("C:/lab/")
setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning")



covid <- read.table("covid_agg.csv", header=TRUE)
covid
head(covid)

summary(covid)

# ggplot2
library(ggplot2)
ggplot(covid, aes(x = lon, y = lat)) + geom_point()

# changing the size of the data...
ggplot(covid, aes(x = lon, y = lat, size = cases)) + geom_point()
