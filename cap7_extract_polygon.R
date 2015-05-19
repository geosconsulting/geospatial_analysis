library(raster)
library(ggmap)
library(rgeos)
library(rgdal)

ndvi = function(x) (x[4] - x[3]) / (x[4] + x[3])

l_00 = brick("Data files/landsat_04_10_2000.tif")
ndvi_00 = calc(l_00, fun = ndvi)

l_98 = brick("Data files/landsat_15_10_1998.tif")
l_03 = brick("Data files/landsat_11_09_2003.tif")
ndvi_98 = calc(l_98, fun = ndvi)
ndvi_03 = calc(l_03, fun = ndvi)

l_dates = as.Date(c("1998-10-15", "2000-10-04", "2003-09-11"))

towns_names = c("Lahav Kibbutz", "Lehavim")
towns = geocode(towns_names)
coordinates(towns) = ~ lon + lat
proj4string(towns) = CRS("+proj=longlat +datum=WGS84")
towns = spTransform(towns, CRS(proj4string(l_00)))

l_rec = ndvi_00
l_rec[l_rec <= 0.2] = 0
l_rec[l_rec > 0.2] = 1
l_rec_focal = focal(l_rec, 
                    w = matrix(1, nrow=3, ncol=3), 
                    fun = max)
l_rec_focal_clump = clump(l_rec_focal, gaps = FALSE)
pol = rasterToPolygons(l_rec_focal_clump,dissolve = TRUE)
pol$area = gArea(pol,byid = TRUE)/1000^2
pol = pol[pol$area>1,]

dist_towns = gDistance(towns,pol,byid = TRUE)
dist_order = order(dist_towns[,1])

forests = pol[dist_order[1:2], ]
forests$name = c("Lahav", "Kramim")

l_forests = extract(stack(ndvi_98,ndvi_00,ndvi_03),forests,fun=mean,na.rm = TRUE)