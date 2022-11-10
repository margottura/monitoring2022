# R code for remote sensing data analysis in ecosystem monitoring

# We are using the "raster" package
install.packages("raster")

library(raster)

# We set the working directory:
setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning")

# We are going to upload the data, using a function called "brick()"

brick("p224r63_2011_masked.grd")
p224r63_2011 <- brick("p224r63_2011_masked.grd")

p224r63_2011

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100)  
plot(p224r63_2011, col=cl)
