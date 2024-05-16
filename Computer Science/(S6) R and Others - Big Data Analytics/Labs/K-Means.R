tmp = sort(state_income$V2)
plot(tmp)
kmeans = kmeans(tmp, 4, 15)
points(kmeans$centers, col=1:4, pch=20)

library(datasets)
data(iris)
plot(iris[,1:2])
kmeans = kmeans(iris[,1:2], 4, 15)
points(kmeans$center, col=1:4, pch=20)

plot(iris[,1:2], col=kmeans$cluster)
points(kmeans$center, col=1:4, pch=20)

withinSumSqrs = numeric(20)
for (k in 1:20)
  withinSumSqrs[k] = sum(kmeans(iris[,1:2], centers=k)$withinss)
plot(1:20, withinSumSqrs, type="b", xlab="# Clusters", ylab="Within sum of square") # Elbow around 3

plot(iris[,1:3])
kmeans = kmeans(iris[,1:3], 4, 15)
plot(iris[,1:3], col=kmeans$cluster)

plot(iris[,1:2], col=kmeans$cluster)
points(kmeans$centers, col=1:4, pch=20)
plot(iris[,c(1,3)], col=kmeans$cluster)
points(kmeans$centers[,c(1,3)], col=1:4, pch=20)

withinSumSqrs = numeric(20)
for (k in 1:20)
  withinSumSqrs[k] = sum(kmeans(iris[,1:3], centers=k)$withinss)
plot(1:20, withinSumSqrs, type="b", xlab="# Clusters", ylab="Within sum of square") # Elbow around 3-4

plot(iris[,1:4])
kmeans = kmeans(iris[,1:4], 4, 15)
plot(iris[,1:4], col=kmeans$cluster)
summary(iris[,1:4]) # petal length will have more impact

myShift = function(x) {x - min(x, na.rm=TRUE)}
myShift(iris[,3])
as.data.frame(lapply(iris[,1:4], myShift))
summary(as.data.frame(lapply(iris[,1:4], myShift)))

myScale = function(x) {max(x, na.rm=TRUE) - min(x, na.RM=TRUE)}
myScale(iris[,3])
as.data.frame(lapply(iris[,1:4], myScale))

myNorm = function(x) {myShift(x) / myScale(x)}
myNorm(iris[,3])
tmp = as.data.frame(lapply(iris[,1:4], myNorm))
summary(as.data.frame(lapply(iris[,1:4], myNorm)))
for (k in 1:20)
  withinSumSqrs[k] = sum(kmeans(tmp[,1:4], centers=k)$withinss)
plot(1:20, withinSumSqrs, type="b", xlab="# Clusters", ylab="Within sum of square") # Elbow is 2
