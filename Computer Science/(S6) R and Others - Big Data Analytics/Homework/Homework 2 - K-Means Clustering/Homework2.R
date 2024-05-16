# Part 0

# 1. One data type that cannot be used for KMeans clustering is categorical data, as it's
#    unclear how one would define the distance between categories

# 2. KMeans clustering is not deterministic, because the centers of the clusters are chosen
#    pseudorandomly, and thus they are not guaranteed to be the same every time.

# Part 1

# 2
plot(Data587)

# 3
set.seed(888)

# 4
withinSumSqrs = numeric(20)
for (k in 1:20) {
  set.seed(888)
  withinSumSqrs[k] = sum(kmeans(Data587[,1:4], centers=k)$withinss)
}
plot(1:20, withinSumSqrs, type="b", 
     xlab="# Clusters", ylab="Within sum of square", 
     main="Number of Clusters vs. Sum of Squares Error") # 5 seems reasonable

# 5
plot(Data587[,1:4])
kmeans = kmeans(Data587[,1:4], 5, 15)
points(kmeans$center, col=1:4, pch=20)
plot(Data587[,1:4], col=kmeans$cluster)

# 6
myShift = function(x) {x - min(x, na.rm=TRUE)}
myScale = function(x) {max(x, na.rm=TRUE) - min(x, na.RM=TRUE)}
myNorm = function(x) {myShift(x) / myScale(x)}

myShift(Data587[,3])
as.data.frame(lapply(Data587[,1:4], myShift))
summary(as.data.frame(lapply(Data587[,1:4], myShift)))
myScale(Data587[,3])
as.data.frame(lapply(Data587[,1:4], myScale))
myNorm(Data587[,3])
tmp = as.data.frame(lapply(Data587[,1:4], myNorm))

# 7
withinSumSqrs = numeric(20)
for (k in 1:20) {
  set.seed(888)
  withinSumSqrs[k] = sum(kmeans(tmp[,1:4], centers=k)$withinss)
}
plot(1:20, withinSumSqrs, type="b", 
     xlab="# Clusters", ylab="Within sum of square", 
     main="Number of Clusters vs. Sum of Squares Error") # 5 seems reasonable

# 8
plot(Data587[,1:4])
kmeans = kmeans(tmp[,1:4], 5, 15)
points(kmeans$center, col=1:4, pch=20)
plot(tmp[,1:4], col=kmeans$cluster)

# 9
# It did not. The plots look similar, and the elbow still appears to be at 5.

# Part 2

# 1
d <- dist(tmp, method="euclidean")
fit <- hclust(d, method="ward.D2")
plot(fit, main="Cluster Diagram of Data",xlab="Categories") # 3 seems reasonable

# 2
Groups <- cutree(fit, k=3)
rect.hclust(fit, k=3, border="red")
