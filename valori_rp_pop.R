rp <- c(100,200,1000,50,500,25)
pop <- c(9053,16710,153,1532,1819,1964)
cum <- c(12549,29259,31231,3496,31078,1964)
valori <- data.frame(rp,pop,cum)

plot(sort(valori$cum)~sort(valori$rp),type = 'l')
barplot(sort(valori$cum))

