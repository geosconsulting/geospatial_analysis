library(raster)

dem_spain = raster("downloaded/spain_elev.tif")
dem_spain = aggregate(dem_spain,4)
spain_stations = read.csv("Data files/spain_stations.csv", 
                          stringsAsFactors = FALSE)
spain_annual = read.csv("Data files/spain_annual.csv", 
                        stringsAsFactors = FALSE)

create_pnt = function(stations,annual,year,variable,new_proj) {
  library(plyr)
  # (1) Promoting stations to SpatialPointsDataFrame
  coordinates(stations) = ~ longitude + latitude
  # (2) Defining geographic CRS
  proj4string(stations) = CRS("+proj=longlat +datum=WGS84")
  # (3) Removing Canary Islands stations
  stations = stations[coordinates(stations)[, 1] > -10, ]
  # (4) Subsetting climatic data
  annual = annual[
    annual$year == year & 
      annual$variable == variable, ]
  # (5) Joining meteorological data with stations layer
  stations@data = join(stations@data, annual, by = "station")
  # (6) Removing incomplete records
  stations = stations[complete.cases(stations@data), ]
  # (7) transforming to the required CRS
  spTransform(stations, CRS(new_proj))
}

laproiez = proj4string(dem_spain)
dat = create_pnt(stations=spain_stations,annual=spain_annual,year=2002,
                 variable = "mmnt",new_proj=laproiez)

grid = rasterToPoints(dem_spain, spatial = TRUE)

#Nearest Neighbour...NON FUNZIONA PER PROIEZIONE
# library(rgeos)
# dist = gDistance(dat, grid, byid = TRUE)
# 
# dim(dist)
# 
# nearest_dat = apply(dist, 1, which.min)
# grid$nn = dat$value[nearest_dat]
# grid = rasterize(grid, dem_spain, "nn")

library(gstat)
g = gstat(formula = value ~ 1, data = dat)
print(g)
z = interpolate(dem_spain, g)
z = mask(z, dem_spain)

# g1 = gstat(formula = value ~ 1, data = dat,set=list(idp=0.3))
# g2 = gstat(formula = value ~ 1, data = dat,set=list(idp=30))
# z1 = interpolate(dem_spain, g1)
# z2 = interpolate(dem_spain, g2)
# z1 = mask(z1, dem_spain)
# z2 = mask(z2, dem_spain)

# par(mfrow = c(1,3), mai = rep(0.4, 4))
# plot(z1,main=c("beta= 0.3"))
# plot(dat,add=TRUE,pch=20,cex=0.5)
# plot(z,main=c("beta= 2"))
# plot(dat,add=TRUE,pch=20,cex=0.5)
# plot(z2,main=c("beta= 30"))
# plot(dat,add=TRUE,pch=20,cex=0.5)

cv = gstat.cv(g,verbose = FALSE)
#rmse = sqrt((sum(-cv$residual)^2)/nrow(cv))
#rmse = sqrt((sum(cv$var1.pred-cv$observed)^2)/nrow(cv))
rmse = function(x) sqrt((sum(x$var1.pred-x$observed)^2)/nrow(x))
rmse(cv)

ev = variogram(g)
plot(ev)

