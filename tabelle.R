num = 1:4
lower = c("a","b","c","d")
upper = c("A","B","C","D")
df = data.frame(num,lower,upper,stringsAsFactors = FALSE)

df$word[df$num == 2] = "Two"
write.csv(df,"df.csv")

row5=c(5,"e","E")
rbind(df,row5)

word = c("One","Two","Three","Four")
cbind(df,word,stringsAsFactors = FALSE)

dat = read.csv("../Data files/343452.csv")
colnames(dat) = tolower(colnames(dat))

dat$tpcp[dat$tpcp == -9999] = NA
dat$mmxt[dat$mmxt == -9999] = NA
dat$mmnt[dat$mmnt == -9999] = NA

dat$tpcp = dat$tpcp/10
dat$mmxt = (5/9)*(dat$mmxt-32)

izana = dat[dat$station_name %in% c("IZANA SP"), c("station","latitude","longitude")]

dat_senza_NA = dat[complete.cases(dat), ]
numero_dati_con_NA = nrow(dat) - nrow(dat_senza_NA)

dat$date = as.Date(as.character(dat$date),format = "%Y%m%d")
dat$month = as.numeric(format(dat$date, "%m"))
dat$year = as.numeric(format(dat$date, "%Y"))

ifelse(dat$mmxt[1:7]<30,"cold","Warm")

#CONVERTO NEGATIVI IN POSITIVI
#x = c(-1,-8,2,5,-5,-9)
#ifelse(x<0, -x, x)
#conteggio = length(x)
#for(k in 0:conteggio){print(k)}

x = tapply(iris$Petal.Width, iris$Species, mean)
  
result = tapply(dat$tpcp,dat$station_name,function(x) any(is.na(x)))
names(result[result])

iris = read.csv("../Data files/iris2.csv")

apply(iris[,1:4], 1,mean)
apply(iris[,1:4], 2,mean)

library(reshape2)
dat_melt = melt(dat, measure.vars = c("tpcp","mmxt","mmnt"))

library(plyr)
ddply(iris, .(Species),summarize,
      sepal_area = mean(Sepal.Length*Sepal.Width),
      petal_area = mean(Petal.Length*Petal.Width))

dat3 = ddply(dat_melt, .(station,year,variable),transform,
             months_available = length(value[!is.na(value)]))

head(dat3)
nrow(dat3)

dat3 = dat3[dat3$months_available == 12,]
nrow(dat3)

spain_stations = ddply(dat3,.(station), summarize,
                       latitude = latitude[1],
                       longitude = longitude[1],
                       elevation = elevation[1])
head(spain_stations)
nrow(spain_stations)
write.csv(spain_stations,"spain_stations.csv", row.names = FALSE)

spain_annual = ddply(dat3, .(station,variable,year),summarize,
                     value = ifelse(variable[1] == "tpcp",
                                    sum(value,na.rm = TRUE),
                                    mean(value,na.rm = TRUE)))

write.csv(spain_annual,"spain_annual.csv", row.names = FALSE)

dates = read.csv("../Data files/modis_dates.csv")
dates$date = as.Date(paste(dates$year,dates$month,dates$day,sep = "-"))

month = c(12,1:11)
season = rep(c("winter","spring","summer","fall"), each = 3)

seasons = data.frame(month,season)
dates = join(dates,seasons,"month")

combined = join(spain_stations, spain_annual,by="station", type="right")
