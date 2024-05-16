set.seed(555)
x = runif(150, 0, 50)
y = 3.142 + x + rnorm(150)*2.5
plot(y ~ x)

m = lm(y ~ x)
str(m)

print(m)
par(mfrow=c(2,2))
plot(m)

# 1. Because the residuals are independent and identically distributed, 
#    there is no correlation between the x-axis and residuals

# 2. The data look normal

# 3. Yes, variance seems constant

# 4. Doesn't look like there are significant outliers

ypred = predict(m)
par(mfrow=c(1,1))
plot(y, y, type='l', xlab="observed", ylab="predicted y")
points(y, ypred)

summary(m)

par(mar=c(5,4,4,2)+0.1)
plot(RealEstate)
summary(RealEstate)

r = lm(RealEstate$Price ~ RealEstate$Size)
str(r)

print(r)
par(mfrow=c(2,2))
plot(r)

# 1. No, the magnitude gets bigger as the prices grow

# 2. Not really, the tails go off the rails

# 3. Definitely not

# 4. Yes, a number of outliers including 754

# 5. It doesn't seem like a good fit

ypred = predict(r)
par(mfrow=c(1,1))
plot(RealEstate$Price, RealEstate$Price, type="l", xlab="Observed y", ylab="Predicted y")
points(RealEstate$Price, ypred)

summary(y)
