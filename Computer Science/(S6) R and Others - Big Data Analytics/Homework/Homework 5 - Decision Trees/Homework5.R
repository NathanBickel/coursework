# Part 1

# P1
titanic_train[,2] = as.factor(titanic_train[,2])

# P2
subset = titanic_train[,c(2,3,5,6,7,8)]

# P3
# a
set.seed(587)
# b
died_indices = which(subset[,"Survived"]==0)
survived_indices = which(subset[,"Survived"]==1)
# c
num_folds = 9
died_class = array(sample(died_indices, length(died_indices)),
                   c(num_folds, length(died_indices) / num_folds))
survived_class = array(sample(survived_indices, length(survived_indices)),
                       c(num_folds, length(survived_indices) / num_folds))

# Part 2
for (j in 0:5) {
  # Step 0
  cpval = 0.008 * 2^(-j)
  print(sprintf("cpval is",cpval, fmt='%s %#.5f'))
  # Step 1
  for (i in 1:num_folds) {
    test_indices = c(died_class[i,], survived_class[i,])
    test_partition = subset[test_indices,]
    train_partition = subset[-test_indices,]
    m <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch,
               data=train_partition,
               method='class',
               control=rpart.control(minsplit=2, cp=cpval))
    if (i == 1) confMat1 = table(predict(m, test_partition[,-1], type="class"), test_partition[,1])
    else confMat1 = confMat1 + table(predict(m, test_partition[,-1], type="class"), test_partition[,1])
  }
  # Step 2
  print(sprintf("Step 2: The sensitivity on the test partitions is",
                sensitivity(confMat1)*100,fmt='%s %#.2f'))
  print(sprintf("Step 2: The specificity on the test partitions is",
                specificity(confMat1)*100,fmt='%s %#.2f'))
  # Step 3
  for (i in 1:num_folds) {
    test_indices = c(died_class[i,], survived_class[i,])
    test_partition = subset[test_indices,]
    train_partition = subset[-test_indices,]
    m <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch,
               data=train_partition,
               method='class',
               control=rpart.control(minsplit=2, cp=cpval))
    if (i == 1) confMat3 = table(predict(m, train_partition[,-1], type="class"), train_partition[,1])
    else confMat1 = confMat3 + table(predict(m, train_partition[,-1], type="class"), train_partition[,1])
  }
  # Step 4
  print(sprintf("Step 4: The sensitivity on the training partitions is",
                sensitivity(confMat3)*100,fmt='%s %#.2f'))
  print(sprintf("Step 4: The specificity on the training partitions is",
                specificity(confMat3)*100,fmt='%s %#.2f'))
}

# Outputs of Values
# [1] "cpval is 0.00800"
# [1] "Step 2: The sensitivity on the test partitions is 88.34"
# [1] "Step 2: The specificity on the test partitions is 67.84"
# [1] "Step 4: The sensitivity on the training partitions is 90.78"
# [1] "Step 4: The specificity on the training partitions is 74.34"
# [1] "cpval is 0.00400"
# [1] "Step 2: The sensitivity on the test partitions is 89.07"
# [1] "Step 2: The specificity on the test partitions is 66.67"
# [1] "Step 4: The sensitivity on the training partitions is 94.26"
# [1] "Step 4: The specificity on the training partitions is 77.30"
# [1] "cpval is 0.00200"
# [1] "Step 2: The sensitivity on the test partitions is 87.61"
# [1] "Step 2: The specificity on the test partitions is 69.88"
# [1] "Step 4: The sensitivity on the training partitions is 95.49"
# [1] "Step 4: The specificity on the training partitions is 78.62"
# [1] "cpval is 0.00100"
# [1] "Step 2: The sensitivity on the test partitions is 86.34"
# [1] "Step 2: The specificity on the test partitions is 69.59"
# [1] "Step 4: The sensitivity on the training partitions is 96.52"
# [1] "Step 4: The specificity on the training partitions is 82.89"
# [1] "cpval is 0.00050"
# [1] "Step 2: The sensitivity on the test partitions is 85.61"
# [1] "Step 2: The specificity on the test partitions is 70.18"
# [1] "Step 4: The sensitivity on the training partitions is 96.72"
# [1] "Step 4: The specificity on the training partitions is 83.22"
# [1] "cpval is 0.00025"
# [1] "Step 2: The sensitivity on the test partitions is 85.61"
# [1] "Step 2: The specificity on the test partitions is 70.18"
# [1] "Step 4: The sensitivity on the training partitions is 96.72"
# [1] "Step 4: The specificity on the training partitions is 83.22"

# Step 6
# For each cpval, the model performs much better on the training data
# than on the testing data. This suggests that the model is overfitting
# to the training data and gives us reason to doubt the model will perform
# well on new data.