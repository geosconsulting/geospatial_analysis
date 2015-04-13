iris = read.csv("../Data files/iris2.csv")
library(plyr)

#media_a = ddply(iris,.(Species),summarise,avg=mean(Sepal.Length))
media_a = summarise(iris,avg=mean(Sepal.Length))
media_a = summarise_each(iris,funs(mean))