library(sp)
library(rgdal)
library(rgeos)

county = readOGR("../Data files", "USA_2_GADM_fips", stringsAsFactors = FALSE)
airports = readOGR(".", "airports", stringsAsFactors = FALSE)

airports = spTransform(airports,CRS(proj4string(county)))

nm = county[county$NAME_1 == "New Mexico", ]
plot(nm)
plot(airports,col="red",pch=15, add=TRUE)

airports@data = cbind(airports@data,over(airports,nm))

plot(nm[airports, ])
plot(airports, add = TRUE, col = "red", pch = 16, cex = 1.5)
text(airports, airports$name, pos = 1)