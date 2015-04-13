library(sp)
library(rgdal)
library(raster)

county = readOGR("../Data files", "USA_2_GADM_fips", 
                 stringsAsFactors = FALSE)
county = county[county$NAME_1 != "Hawaii" & county$NAME_1 != "Alaska" ,]
county = county[county$TYPE_2 != "Water body",]

newProj = CRS("+proj=laea +lat_0=45 +lon_0=-100 + x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs")
county = spTransform(county, newProj)

l_03 = brick("../Data files/landsat_11_09_2003.tif")


track = readOGR("../Data files/GPS_log.gpx","tracks")
proiezione = CRS(proj4string(l_03))
track = spTransform(track,proiezione)

#plotRGB(l_03,r=3,g=2,b=1,stretch="lin", ext=extent(track)+10000)
#plot(track,add=TRUE,col="yellow")

library(rgeos)
areaTotale = gArea(county)/1000^2
county$area = gArea(county,byid=TRUE)/1000^2

county_nv_ut = county[county$NAME_1 %in% c("Nevada","Utah"),]

states = gUnaryUnion(county_nv_ut, id = county_nv_ut$NAME_1)

plot(county_nv_ut,border="lightgrey",lty="dotted")
county_ctr = gCentroid(county_nv_ut,byid=TRUE)
text(county_ctr,county_nv_ut$NAME_2,cex=0.5,col="red")
plot(states,add=TRUE)


