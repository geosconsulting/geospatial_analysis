dat = read.csv("C:\\Users\\fabio.lana\\workspace\\Learning R for Geospatial Analysis\\Data files\\338284.csv", stringsAsFactors = FALSE)
time = dat$DATE
tmax = dat$TMAX

time = as.Date(as.character(time),format="%Y%m%d")
tmax[tmax == -9999] = NA
tmax = tmax/10

range_t = range(time)
all_dates = seq(range_t[1],range_t[length(range_t)],1)

all(all_dates %in% time)
all_dates[which(!(all_dates %in% time))]
max(tmax,na.rm=TRUE)

time[which.max(tmax)]

w = time>as.Date("2005-12-31") & time<as.Date("2014-1-1")
sum(w)/length(w)

time = time[w]
tmax = tmax[w]

#plot(time,tmax,type="l")
pdf("time_series.pdf")
plot(tmax~time,type="l")
dev.off()

dat = data.frame(time=time,tmax=tmax)

plot(tmax~time,dat,type="l")

library(lattice)
xyplot(tmax~time,data=dat,type="l")

library(ggplot2)
ggplot(dat,aes(x=time,y=tmax)) + geom_line()