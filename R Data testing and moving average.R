#### Set up ####



setwd("C:/Taha/Uni/Economics/ECON321 - Sports Economics/Data & Working Directory/R Working Directory")
library(zoo)

constructor_results <- read.csv("constructor_results.csv")
races2010onwards <- read.csv("MODraces2010onwards.csv")
races2019onwards <- read.csv("MODraces2019onwards.csv")
seasonroundcount <- read.csv("MODseasonsroundcount.csv")
attach(constructor_results)
sprintraces.raceid <- list(1061, 1065, 1071, 1077, 1084, 1095)



#### Defining working variables ####

#results variables
merc.gpnum <- c()
merc.resultid <- c()
merc.raceid <- c()
merc.points <- c()
merc.percpoints <- as.double(c())
merc.percTOTALpoints <- as.double(c())

#setting variables
newpointsys <- c()
merc.year <- c()
merc.round <- c()
merc.seasonandround <- as.double(c())

#mercresults <- data.frame(merc.gpnum, merc.resultid, merc.raceid, merc.points, newpointsys, merc.year)




#### Data set querying ####

#Results query - Team results identification
#Mercedes constructorid = 131
j = 1
for (i in 1:dim(constructor_results)[1]) {
  if (raceId[i] %in% races2010onwards$raceId) {
    if (constructorId[i] == 131) {
      merc.gpnum[j] <- j
      merc.resultid[j] <- constructorResultsId[i]
      merc.raceid[j] <- raceId[i]
      merc.points[j] <- points[i]
      j = j + 1
    }
  }
}
j = j - 1

#GP information query - Season/round identification
#Get season and round
for (i in 1:length(merc.gpnum)) {
  temprow <- races2010onwards[races2010onwards$raceId == merc.raceid[i],]
  merc.year[i] <- as.numeric(temprow[2])
  merc.round[i] <- as.numeric(temprow[3])
}
#Assign newpointsys
for (i in 1:length(merc.gpnum)) {
  ifelse(merc.raceid[i] %in% races2019onwards$raceId, newpointsys[i] <- TRUE, newpointsys[i] <- FALSE)
}




#### General season/rounds time-mapping variable ####
for (i in 1:length(merc.gpnum)) {
  totalrounds <- as.numeric(seasonroundcount[seasonroundcount$year == merc.year[i], ][2])
  merc.seasonandround[i] <- as.double(merc.year[i] + ((merc.round[i]-1) / totalrounds))
}
#N/B: Using this formula,
#The last race of each year will be equal to next year if you don't do merc.round -1
#as round / total rounds is = 1 in those cases




#### %Points Calc ####
for (i in merc.gpnum) {
  if (newpointsys[i] == TRUE) {
    maxpoints <- 25 + 18 + 1
  }
  if (newpointsys[i] == FALSE) {
    maxpoints <- 25 + 18
  }
  #correcting for double points awarded on Abu Dhabi 2014
  if (merc.year[i] == 2014) {
    if (merc.round[i] == 19) {
      maxpoints <- 50 + 36
    }
  }
  #correcting for sprint races
  if ((merc.raceid[i] %in% sprintraces.raceid) == TRUE) {
    maxpoints <- 25 + 8 + 18 + 7 + 1
  }
  merc.percpoints[i] <- (merc.points[i] / maxpoints)*100
}




#### %FULLGRIDPoints calc. ####
for (i in merc.gpnum) {
  if (newpointsys[i] == TRUE) {
    maxTOTALpoints <- 1 + 25 + 18 + 15 + 12 + 10 + 8 + 6 + 4 + 2 + 1 
  }
  if (newpointsys[i] == FALSE) {
    maxTOTALpoints <- 25 + 18 + 15 + 12 + 10 + 8 + 6 + 4 + 2 + 1 
  }
  #correcting for double points awarded on Abu Dhabi 2014
  if (merc.year[i] == 2014) {
    if (merc.round[i] == 19) {
      maxTOTALpoints <- 50 + 36 + 30 + 24 + 20 + 16 + 12 + 8 + 4 + 2
    }
  }
  #correcting for sprint races
  if ((merc.raceid[i] %in% sprintraces.raceid) == TRUE) {
    maxTOTALpoints <- 1 + 25 + 18 + 15 + 12 + 10 + 8 + 6 + 4 + 2 + 1 + 8 + 7 + 6 + 5 + 4 + 3 + 2 + 1
  }
  merc.percTOTALpoints[i] <- (merc.points[i] / maxTOTALpoints)*100
}




#### Plotting ####

#Graphical tests
#plot(merc.seasonandround, merc.percpoints)

#Moving averages %points
temp.zoo <- zoo(merc.percpoints, merc.gpnum)
zoo.rollmean <- c()
zoo.rollmean <- rollmean(temp.zoo, 5, align = "right")
#plot on same domain (based on zoo domain)
domain.beg <- 5
domain.end <- 259
plot(merc.seasonandround[domain.beg:domain.end], merc.percpoints[domain.beg:domain.end])
#plot next graph on same plot
par(new = TRUE)
plot(merc.seasonandround[domain.beg:domain.end], zoo.rollmean, type = "l", col = "red", lwd = 2, xaxt = "n", yaxt = "n", ylab = "", xlab = "")

#Notes:
#For now, a right aligned rollmean with an interval width of k = 4 or 5 looks to be good/stable
#Recommended export settings: landscape 8in x 6in (1.5 aspect ratio) is a decent balance of UI size & precision
#May want to increase things like line width but 1 or 0.5 of a unit or something tho
#could use a lil yassifying


#### FINAL OUTPUTS ####

#Write data
output.df <- data.frame(merc.gpnum, merc.resultid, merc.raceid, merc.points, merc.percpoints, merc.percTOTALpoints, merc.year, merc.round, merc.seasonandround, newpointsys)
write.csv(output.df, "C:/Taha/Uni/Economics/ECON321 - Sports Economics/Data & Working Directory/Output/merc.results.csv", row.names = FALSE)


#Moving average %Points plot (copy paste for final document version tweaks)
temp.zoo <- zoo(merc.percpoints, merc.gpnum)
zoo.rollmean <- c()
zoo.rollmean <- rollmean(temp.zoo, 5, align = "right")
#plot on same domain (based on zoo domain)
domain.beg <- 5
domain.end <- 259
plot(merc.seasonandround[domain.beg:domain.end], merc.percpoints[domain.beg:domain.end], main = "% Maximum Possible Points", ylab = "Percent of points", xlab = "Season", axes = TRUE)
#plot next graph on same plot
par(new = TRUE)
plot(merc.seasonandround[domain.beg:domain.end], zoo.rollmean, type = "l", col = "red", lwd = 2, xaxt = "n", yaxt = "n", ylab = "", xlab = "")
#Define axis step
xlabel <- seq(2010, 2023, by = 1)
ylabel <- seq(0, 50, by = 5)
#Plot axis
axis(1, at = xlabel)
#axis(2, at = ylabel)
#add a dashed blue vertical line
abline(v = c(2014, 2022), lty = 2,lwd = 2, col = "blue")



#Moving Average %TOTALPoints plot
temp.zoo <- zoo(merc.percTOTALpoints, merc.gpnum)
zoo.rollmean <- c()
zoo.rollmean <- rollmean(temp.zoo, 5, align = "right")
#plot on same domain (based on zoo domain)
domain.beg <- 5
domain.end <- 259
plot(merc.seasonandround[domain.beg:domain.end], merc.percTOTALpoints[domain.beg:domain.end], main = "% Total Grid's Points", ylab = "Percent of points", xlab = "Season", axes = FALSE)
#plot next graph on same plot
par(new = TRUE)
plot(merc.seasonandround[domain.beg:domain.end], zoo.rollmean, type = "l", col = "red", lwd = 2, xaxt = "n", yaxt = "n", ylab = "", xlab = "")
#Define axis step
xlabel <- seq(2010, 2023, by = 1)
ylabel <- seq(0, 50, by = 5)
#Plot axis
axis(1, at = xlabel)
axis(2, at = ylabel)

#add a dashed blue vertical line
abline(v = c(2014, 2022), lty = 2,lwd = 2, col = "blue")

