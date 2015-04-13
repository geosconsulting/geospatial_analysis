addresses = c(
  "2200 Sunport Blvd, Albuquerque, NM 87106, USA", 
  "7401 Paseo Del Volcan Northwest Albuquerque, NM 87121, USA",
  "121 Aviation Dr, Santa Fe, NM 87507, USA")

library(ggmap)
airports = geocode(addresses)

airports$name = c("Albuquerque International","Double Eagle II","Santa Fe Minucipal")
library(sp)

coordinates(airports) = ~lon + lat
proj4string(airports) = CRS("+proj=longlat +datum=WGS84")

library(rgdal)
#writeOGR(airports,".","airports","ESRI Shapefile")
airports_senzaAttributi = as(airports,"SpatialPoints")

track = readOGR("../Data files/GPS_log.gpx","tracks")

county = readOGR("../Data files", "USA_2_GADM_fips", 
                 stringsAsFactors = FALSE)
attributi_county = county@data

county = county[county$NAME_1 != "Hawaii" & county$NAME_1 != "Alaska" ,]
county = county[county$TYPE_2 != "Water body",]
plot(county)