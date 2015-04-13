library(raster)
library(rgdal)
library(rasterVis)

#dates = read.csv("../Data files/modis_dates.csv")

seasons = c("winter", "spring", "summer", "fall")
season_means = stack()

for(i in seasons) {
  season_means = stack(season_means,
                 overlay(r[[which(dates$season == i)]],
                 fun = function(x) mean(x, na.rm = TRUE)))
}

names(season_means) = seasons