library("MASS")
data(menarche)
str(menarche)

summary(menarche)

plot(Menarche/Total ~ Age, data=menarche)

glm.out = glm(cbind(Menarche, Total-Menarche) ~ Age, family=binomial(logit), data=menarche)

plot(Menarche/Total ~ Age, data=menarche)
lines(menarche$Age, glm.out$fitted, type="l", col="red")
title(main="Menarche Data with Fitted Logistic Regression Line")

summary(glm.out)
