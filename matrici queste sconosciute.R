x = matrix(7:12, ncol=3, byrow=FALSE)

xapply = apply(x,2,mean)
xrowmean = rowMeans(x)
xcolmean = colMeans(x)

y = array(1:24,c(4,2,3))
print(y[,,2])
yapply = apply(x,2,mean)
print(rowMeans(y,2))