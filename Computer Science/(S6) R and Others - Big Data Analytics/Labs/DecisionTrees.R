fit = rpart(Species ~ Petal.Length + Petal.Width + Sepal.Length + Sepal.Width, method="class", data=iris, control=rpart.control(minsplit=2, cp=0.001))
print(fit)

par(mar=c(5.1,4.1,4.1,2.1))
plot(fit, uniform=TRUE, main="Classification Tree for Iris Dataset")
text(fit, use.n=TRUE, all=TRUE, cex=0.5)
