library(raster)

l_00 = brick("../Data files/landsat_04_10_2000.tif")

ndvi = function(x) (x[4] - x[3]) / (x[4] + x[3])
ndvi_00 = calc(l_00, fun = ndvi)

l_rec = ndvi_00
l_rec[l_rec <= 0.2] = 0
l_rec[l_rec > 0.2] = 1

l_rec_focal = focal(l_rec,w = matrix(1,nrow=3,ncol=3),fun=max)
l_rec_focal_clump = clump(l_rec_focal, gaps= FALSE)
plot(l_rec)
plot(l_rec_focal)
plot(l_rec_focal_clump)
