# Step 0
colnames(gold_target1) = c("As_Level", "Sb_Level", "Lineament_Proximity", "Gold_Deposit_Proximity")

# Step 1
plot(Gold_Deposit_Proximity ~ As_Level, data=gold_target1,
     xlab="As Level", ylab="Gold Deposit Proximity", main="Gold Deposit Proximity vs As Level")
plot(Gold_Deposit_Proximity ~ Sb_Level, data=gold_target1,
     xlab="Sb Level", ylab="Gold Deposit Proximity", main="Gold Deposit Proximity vs Sb Level")

lrm1 = glm(Gold_Deposit_Proximity ~ Sb_Level, family=binomial(logit), data=gold_target1)
plot(gold_target1$Gold_Deposit_Proximity~gold_target1$Sb_Level,
     xlab="Sb Level", ylab="Gold Deposit Proximity", main="Gold Deposit Proximity vs Sb Level")
lines(gold_target1$Sb_Level,lrm1$fitted,type="l", col="red")

lrm2 = glm(Gold_Deposit_Proximity ~ Sb_Level+As_Level, family=binomial(logit), data=gold_target1)

summary(lrm1)
summary(lrm2)

# For the first model, the estimated coefficient for Sb_Level is 1.761
# For the second, it is 0.924

# The confidence is much higher for the first model: the P value is 2.37e-05
# for the first model, while it is a somewhat unconvincing 0.040 for the second