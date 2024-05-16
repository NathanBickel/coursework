# Problem 1
cutoff = 10000000
salaries = Kaggle_football_salaries[, "avg_year"]
BigBucks = Kaggle_football_salaries[which(salaries >= cutoff),]
# (a)
print(nrow(BigBucks)) # Output: 316
# (b)
scaling = 1000000
hist(BigBucks[, "avg_year"] / scaling, 
     xlab = "Average Salary (millions of dollars)", 
     main = "Average Salaries of High-Paid NFL Players", 
     breaks = 40)

# Problem 2
print(Kaggle_football_salaries[which(salaries == min(salaries)),]) # Output: LaRoy Reynolds

# Problem 3
cutoff = 20000000
print(length(which(salaries > cutoff))) # Output: 29

# Problem 4
teams = Kaggle_football_salaries[,"team"]
# Chiefs Analysis
Chiefs = Kaggle_football_salaries[which(teams == "Chiefs"),]
csalaries = Chiefs[,"avg_year"]
print(sum(csalaries)) # Output: 377717549
print(max(csalaries)) # Output: 20800000
print(unique(droplevels(Chiefs[which(csalaries == max(csalaries)), "player"]))) # Output: Frank Clark
print(mean(csalaries)) # Output: 2183338
hist(csalaries / scaling, 
     xlab = "Average Salary (millions of dollars)", 
     main = "Average Salaries of Chiefs Players",
     breaks = 20)
# 49ers Analysis
FortyNiners = Kaggle_football_salaries[which(teams == "49ers"),]
fsalaries = FortyNiners[,"avg_year"]
print(sum(fsalaries)) # Output: 425218107
print(max(fsalaries)) # Output: 27500000
print(unique(droplevels(FortyNiners[which(fsalaries == max(fsalaries)), "player"]))) # Output: Jimmy Garoppolo
print(mean(fsalaries)) # Output: 2577079
hist(fsalaries / scaling, 
     xlab = "Average Salary (millions of dollars)", 
     main = "Average Salaries of 49ers Players",
     breaks = 20)
