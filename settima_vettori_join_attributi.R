library(sp)
library(rgdal)
library(rgeos)

county = readOGR("../Data files", "USA_2_GADM_fips")
county = county[county$NAME_1 != "Hawaii" & county$NAME_1 != "Alaska" ,]
county = county[county$TYPE_2 != "Water body",]


dat = read.csv("../Data files/CO-EST2012-Alldata.csv")
selected_cols = c("STATE","COUNTY","CENSUS2010POP")
dat = dat[,colnames(dat) %in% selected_cols]
colnames(dat) = tolower(colnames(dat))
dat = dat[dat$county !=0,]
dat$state = formatC(dat$state,width=2,flag = "0")
dat$county = formatC(dat$county,width=3,flag = "0")

dat$FIPS = paste0(dat$state,dat$county)
newProj = CRS("+proj=laea +lat_0=45 +lon_0=-100 
  +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs")
county = spTransform(county, newProj)
county$area = gArea(county, byid = TRUE) / 1000^2

library(plyr)
county@data = join(county@data,dat[,colnames(dat) %in% c("FIPS","census2010pop")],by="FIPS")
county$density=county$census2010pop/county$area


