data("Groceries")
Groceries

summary(Groceries)
image(Groceries)
image(Groceries[1:200,])

rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.5))
inspect(rules)
plot(rules)
plot(rules, shading="order", control=list(main = "Two-key plot"))

inspect(rules[1:20])
inspect(head(sort(rules, by="lift"),5))
rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.8))

plot(head(sort(rules, by="lift"), 500), method="grouped") # Dark spots have more lift
plot(head(sort(rules, by="lift"), 50), method="grouped")

data(Epub)
Epub
summary(Epub)
image(Epub)
image(Epub[1:1000,])

rules2 <- apriori(Epub)
rules2 <- apriori(Epub, parameter=list(support=0.001, confidence=0.5))
rules3 <- apriori(Epub, parameter=list(support=0.01, confidence=0.5))

inspect(rules2)
inspect(head(sort(rules2,by="lift"),10))
plot(rules2)
plot(rules2, shading="order", control=list(main="Two-key plot"))
plot(head(sort(rules2, by="lift"), 50), method="grouped")
