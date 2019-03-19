# Title     : SOEN6611 Assignment1
# Objective : logisitc regression
# Created by: kenlo
# Created on: 2019-03-16

Sys.setenv(LANG = "en")

file1 = 'qt50.csv'
# fixme: qt51 is useless, it's missing the post_bugs column to use as a test set
# file2 = 'qt51.csv'
# print(header)
# print(head(data, 6))

csvFile <- read.csv(file1, head=TRUE)
# testSet <- read.csv(file2, head=TRUE)
# print the first 6 rows
# print(head(my_data, 6))
# print(summary(data))

# select all numerical values column
dataSet <- csvFile[c(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)]
# testSet <- testSet[c(2,3,4,5,6,7,8,9,10,11,12,13,14)]
attach(dataSet)
# allow us to call the data in a column by its name
names(dataSet)

# print(mean(size))
# print(mean(self_reviews))

# isolate the dependent variable and change its outcome to 0 or 1 for glm()
dependent_var <- post_bugs
# print(summary(dependent_var))
# print(length(dependent_var))
for(i in 1:length(dependent_var)){
    # print(i)
    x <- dependent_var[i]
    # print(x)
    if (x > 0){
        # print('True')
        dependent_var[i] <- 1
    }
}
#put is back in the dataSet
dataSet[c('post_bugs')] <- dependent_var

#for information purpose
print(summary(dataSet))

# split the dataset in a 90% training set and 10% testing set
train_int <- floor(0.9*nrow(dataSet))
# print(train_int)
trainSet <- dataSet[1:train_int, ]
testSet <- dataSet[(train_int+1):nrow(dataSet),]

# print(summary(trainSet))
# print(summary(testSet))

# todo: uncomment if you want to calculate spearman correlation coefficient
# correlation <- cor(my_data, use = "complete.obs", method="spearman")
# correlation <- round(correlation, 2)
# print(correlation)
# todo: uncomment to output spearman coefficient to a csv file
# write.csv(correlation, "qt50_spearman.csv")

print('buiding initial model...')
# building a model using all the main features
full_formula <- post_bugs ~ size+complexity+change_churn+prior_bugs+total+minor+major+ownership+reviews+review_rate+review_churn_rate+self_reviews+too_quick+little_discussion
full_model <-glm(full_formula, family=binomial("logit"), data=trainSet)
print(summary(full_model))

print('reducing model with \'step\'...')
# reduced_formula <- post_bugs ~ size+complexity+change_churn+prior_bugs+total+minor+ownership+reviews+self_reviews+too_quick+little_discussion
# reduced_model <-glm(reduced_formula, family=binomial("logit"), data=trainSet)
reduced_model1 <- step(full_model)
print(summary(reduced_model1))

print('refining model with \'update\'...')
reduced_model2<- update(reduced_model1,~.-change_churn)
print(summary(reduced_model2))

print(anova(reduced_model1, reduced_model2, test="Chi"))

#check for non linearity
reduced_model3<- update(reduced_model2,~.+I(complexity^2)+I(prior_bugs^2))
print(summary(reduced_model3))

print(anova(reduced_model2, reduced_model3, test="Chi"))
print('Checking for non linearity of complexity and prior_bugs had a strong impact on Deviance which is not desirable. It did not improve the Model')

print('retained_model is reduced_model2')

retained_model <- reduced_model2

# apply model to test sample
print('Applying retained_model to the testSet')
test_prediciton <- predict(retained_model, testSet, type="response")
# print(summary(test_prediciton))


# print(nrow(testSet))
# print(nrow(test_prediciton)) #null can't querry rows for a predicition function
print('Outputting predicition and test set to .csv file for accuracy analysis in excel')
# output prediciton to .csv file
write.csv(test_prediciton, "prediction.csv")
# write.csv(test_prediciton, "prediction_new.csv")
test_set <- testSet[c('post_bugs')]
write.csv(test_set, "test.csv")
# write.csv(test_set, "test_new.csv")

# comparisaon between the predicted values and actual value is later done in Excel