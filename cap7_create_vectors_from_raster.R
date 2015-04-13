library(raster)
library(ggmap)
library(rgeos)
library(rgdal)

r = brick("Data files/modis.tif")
u = r[[1:2]][1:3, 1:3, drop = FALSE]
u[2,3] = NA
u[[1]][3,2] = NA

u_pnt = rasterToPoints(u,spatial = TRUE)
#plot(u[[1]])
#plot(u_pnt, add = TRUE)
dati = u_pnt@data

haifa_buildings = readOGR("Data files", "haifa_buildings")
haifa_surrounding = extent(haifa_buildings) + 0.25
dem = raster("dem.tif")
dem = crop(dem, haifa_surrounding)
dem = projectRaster(from = dem, 
                    crs = proj4string(r), 
                    method = "ngb", 
                    res = 90)

dem_contour = rasterToContour(dem,levels = seq(0,500,100))
#plot(dem)
#plot(dem_contour,add=TRUE)

slope = terrain(dem, "slope")
aspect = terrain(dem, "aspect")

l_00 = brick("Data files/landsat_04_10_2000.tif")
ndvi = function(x) (x[4] - x[3]) / (x[4] + x[3])
ndvi_00 = calc(l_00, fun = ndvi)
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
#plotRGB(l_00,r=3,g=2,b=1, stretch = "lin")
#plot(pol,border="yellow",lty="dotted",add=TRUE)

towns_names = c("Lahav Kibbutz", "Lehavim")
towns = geocode(towns_names)
coordinates(towns) = ~ lon + lat
proj4string(towns) = CRS("+proj=longlat +datum=WGS84")
towns = spTransform(towns, CRS(proj4string(l_00)))
dist_towns = gDistance(towns,pol,byid = TRUE)
dist_order = order(dist_towns[,1])
forests = pol[dist_order[1:2], ]
forests$name = c("Lahav", "Kramim")

plotRGB(l_00, r = 3, g = 2, b = 1, stretch = "lin")
plot(towns[1, ], col = "red", pch = 16, add = TRUE)
plot(pol, border = "yellow", lty = "dotted", add = TRUE)
plot(forests, border = "red", lty = "dotted", add = TRUE)
text(gCentroid(pol, byid = TRUE), round(dist_towns[,1]), col = "White")
