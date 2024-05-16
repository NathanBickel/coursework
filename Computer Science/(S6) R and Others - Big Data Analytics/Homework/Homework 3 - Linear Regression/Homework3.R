co2 <- read.csv("~/co2.csv", row.names=1, stringsAsFactors=FALSE)
plot(co2[,"decimal.date"],co2[,"interpolated"],main="Interpolated vs Date",xlab="Date",ylab="Interpolated")

par(mfrow=c(2,2))
plot(m)

# The residuals vs fitted graph shows the deviation from the regression line over the values.
# There is a clear quadratic pattern, and it is very unlikely that this pattern would emerge
# by random chance. This indicates that a linear regression model is not a good choice.

ypred = predict(m)
par(mfrow=c(1,1))
plot(co2[,"interpolated"], co2[,"interpolated"], type='l', xlab="observed", ylab="predicted y")
points(co2[,"interpolated"], ypred)

len = length(co2[,"interpolated"])
plot(co2[(len-24):len,"interpolated"] ~ co2[(len-24):len,"decimal.date"], 
     main="Recent Interpolated vs Date", xlab="Date", ylab="Interpolated")

# These data do not appear to be iid. In particular, it seems that the values go up and down 
# cyclically each year, which suggests some seasonal effects.