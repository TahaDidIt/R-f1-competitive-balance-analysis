#### Set up ####

setwd("C:/Taha/Uni/Economics/ECON321 - Sports Economics/Data & Working Directory/R Working Directory")
standings <- read.csv("team constructors variation.csv")
attach(standings)
redbull <- read.csv("team rb constructors variation.csv")
ferrari <- read.csv("team ferrari constructors variation.csv")
mercedes <- read.csv("team merc constructors variation.csv")
mclaren <- read.csv("team mclaren constructors variation.csv")
williams <- read.csv("team williams constructors variation.csv")


#### Visualisation ####
#Plot line graphs with no axis (as axis scale is not ideal)
par(bg = "light grey")
plot(redbull$year, redbull$position, ylim = rev(c(1,3)), type = "l", lwd = 4, col = "blue", axes = FALSE,
     ylab = "Constructors Standings", xlab = "Year")
par(new = TRUE)
plot(mercedes$year, mercedes$position, ylim = rev(c(1,3)), type = "l", lwd = 4, col = "green", axes = FALSE,
     ylab = "", xlab = "")
par(new = TRUE)
plot(ferrari$year, ferrari$position, ylim = rev(c(1,3)), type = "l", lwd = 4, col = "red", axes = FALSE,
     ylab = "", xlab = "")
par(new = TRUE)
plot(mclaren$year, mclaren$position, ylim = rev(c(1,3)), type = "l", lwd = 2, col = "orange", axes = FALSE,
     ylab = "", xlab = "")
par(new = TRUE)
plot(williams$year, williams$position, ylim = rev(c(1,3)), type = "l", lwd = 2, col = "cyan", axes = FALSE,
     ylab = "", xlab = "")
#Define axis step
xlabel <- seq(2010, 2022, by = 1)
ylabel <- seq(1,3, by = 1)
#Plot axis
axis(1, at = xlabel)
axis(2, at = ylabel)



#### Variance ####

rb.var <- var(redbull$position)
rb.var

merc.var <- var(mercedes$position)
merc.var
#2014 -> 2021
merc.varbetweenregs <- var(mercedes$position[2:9])
merc.varbetweenregs

ferrari.var <- var(ferrari$position)
ferrari.var

mclaren.var <- var (mclaren$position)
mclaren.var

williams.var <- var(williams$position)
williams.var
