iris_data <- iris[,-5]
iris_pca <- prcomp(iris_data, center = TRUE, scale. = TRUE)
print(iris_pca)

tot_var <- sum(sapply(iris_pca$sdev, function(x) x*x))
pct_var <- sapply(iris_pca$sdev,function(x) x*x/tot_var)
plot(pct_var,type="l")

sum(pct_var[1:2])
autoplot(iris_pca)

autoplot(iris_pca, data=iris, colour='Species')

autoplot(iris_pca, data=iris, colour='Species', label=TRUE, label.size=3)

autoplot(iris_pca, data = iris, colour = 'Species', loadings = TRUE, loadings.colour = 'blue',loadings.label = TRUE, loadings.label.size = 3)

tmp <- icu[,-c(1, 2)]
pca_tmp <- prcomp(tmp, center = TRUE, scale. = TRUE)
print(pca_tmp)
plot(pca_tmp, type="l")
tot_var <-sum(sapply(pca_tmp$sdev,function(x) x*x))

pct_var <- sapply(pca_tmp$sdev,function(x) x*x/tot_var)
plot(pct_var, type="l")
sum(pct_var[1:10])

autoplot(pca_tmp)
plot(pca_tmp$x[,1:2])
autoplot(pca_tmp, data = icu, colour = 'STA')
plot(pca_tmp$x[,1:2], col=icu[,2]+1)