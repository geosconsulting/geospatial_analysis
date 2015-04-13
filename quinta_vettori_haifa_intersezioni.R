library(sp)
library(rgdal)
library(rgeos)
library(raster)


haifa_buildings = readOGR("../Data files", "haifa_buildings")
haifa_natural = readOGR("../Data files", "haifa_natural")
israel_adm = getData("GADM",country = "ISR", level = 1)
haifa_adm = israel_adm[israel_adm$NAME_1 == "Haifa",]

l_03 = brick("../Data files/landsat_11_09_2003.tif")

haifa_adm = spTransform(haifa_adm, CRS(proj4string(l_03)))
haifa_buildings = spTransform(haifa_buildings, CRS(proj4string(l_03)))
haifa_natural = spTransform(haifa_natural, CRS(proj4string(l_03)))


plot(haifa_natural, col = "lightgreen")
plot(haifa_buildings, add = TRUE)
plot(haifa_adm, add = TRUE)

buildings_ch = gConvexHull(haifa_buildings)
buildings_ch = gIntersection(buildings_ch,haifa_adm)
haifa_natural = gUnaryUnion(haifa_natural)
haifa_natural = gIntersection(haifa_natural, buildings_ch)

buildings_50m = gBuffer(haifa_buildings, width = 50)
haifa_natural = gDifference(haifa_natural, buildings_50m)
plot(buildings_ch, col = "lightgrey", border = "lightgrey")
plot(haifa_adm, add = TRUE)
plot(haifa_natural, col = "lightgreen", add = TRUE)
plot(haifa_buildings, add = TRUE)
