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

# To see only the plot of the first band we do this
plot(p224r63_2011$B1_sre, col=cl)

# If you know the position of the band you can also do this
plot(p224r63_2011[[1]], col=cl)

# Excercise: change the color ramp palette with colours drom dark to light blue
cl <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011, col=cl)

# If we want to put images in a row we do this:

par(mfrow=c(1,2))
plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)

# Excercise: put all the 4 images in 2 different rows

par(mfrow=c(2,2))
plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)
plot(p224r63_2011[[3]], col=cl)
plot(p224r63_2011[[4]], col=cl)
