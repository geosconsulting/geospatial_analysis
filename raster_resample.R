library(raster)


r = brick("../Data files/modis.tif")

min_ndvi = min(r,na.rm = TRUE)
range_ndvi = range(r, na.rm = TRUE)
dates = read.csv("../Data files/modis_dates.csv")
dates$date = as.Date(paste(dates$year,dates$month,dates$day,sep="-"))

l_00 = brick("../Data files/landsat_04_10_2000.tif")

ndvi = function(x) (x[4]-x[3] / x[4]+x[3])
ndvi_00 = calc(l_00,fun = ndvi)

l_date = which.min(abs(dates$date - as.Date("2000-10-04")))

l_resample = resample(ndvi_00,r[[l_date]],method = "ngb")
plot(ndvi_00,main="Original Landsat image")
plot(l_resample,ext = extent(ndvi_00), main = "Resampled to MODIS")

r_resample = resample(r[[l_date]], ndvi_00, method = "ngb")
r_resample = extend(r_resample, r[[l_date]])
plot(r[[l_date]], main = "Original MODIS image")

plot(extent(ndvi_00), add = TRUE)
plot(r_resample, main = "Resampled to Landsat")

r_resample_ngb = resample(r[[l_date]],ndvi_00, methods="ngb")
r_resample_bil = resample(r[[l_date]],ndvi_00, methods="bilinear")

resample_results = stack(r_resample_ngb,r_resample_bil)
names(resample_results) = c("Nearest neighbour","Bilinear interpolation")

library(rasterVis)
levelplot(resample_results, par.settings = RdBuTheme,contour = TRUE)
