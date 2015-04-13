library(sp)

load("C:/data/tools/conflicts/GAULR_Sudan/SDN_adm2.RData")
sudan.adm2.spdf <- get("gadm")

load("C:/data/tools/conflicts/GAULR_Sudan/SSD_adm2.RData")
south_sudan.adm2.spdf <- get("gadm")

plot(sudan.adm2.spdf,col="sandybrown")
plot(south_sudan.adm2.spdf,col="lightblue", add=TRUE)
