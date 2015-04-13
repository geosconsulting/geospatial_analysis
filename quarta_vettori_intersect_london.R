library(sp)
library(rgdal)
library(rgeos)

boundary = readOGR("../Data files", "CTYUA_DEC_2013_EW_BFE")
buildings = readOGR("../Data files", "london_buildings")
natural = readOGR("../Data files", "london_natural")

buildings = spTransform(buildings,CRS(proj4string(boundary)))
natural = spTransform(natural,CRS(proj4string(boundary)))

city = boundary[boundary$CTYUA13NM == "City of London", ]
in_city = gContains(city,buildings,byid=TRUE)

buildings = buildings[in_city[ ,1], ]
river = natural[natural$type == "riverbank",]
river = gUnaryUnion(river)

plot(buildings,col="sandybrown")
plot(river,col="lightblue", add=TRUE)
plot(boundary,border="dimgrey", add=TRUE)

dist = gDistance(buildings, river, byid = TRUE)
buildings$dist_river = dist[1, ]
