# Title     : TODO
# Objective : TODO
# Created by: kenlo
# Created on: 2019-03-16

Sys.setenv(LANG = "en")

file = 'qt50.csv'
# data <- read.csv(file)
# data <- read.csv(file,head=TRUE,sep=",")
# print(header)
# print(head(data, 6))

# Or, if .csv file, use this
my_data <- read.csv(file, head=TRUE)
# print the first 6 rows
# print(head(my_data, 6))
# print(summary(data))

my_data <- my_data[c(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)]

res <- cor(my_data, use = "complete.obs", method="spearman")
res <- round(res, 2)
print(res)

attach(my_data)
names(my_data)
print(mean(size))
print(mean(self_reviews))

# x <- self_reviews
# # print(x)
# # in the 13 columns
# for (i in x) {
#
#         if(x[i] > 0) # Found a negative value
#         {
#             x[i]=1 # Change to a new non-negative value
#         }
# }




# for (i in names(my_data)) {
#             if(i == "self_reviews") # Found a negative value
#             {
#                 for (j in my_data[[i]]){
#                     if (j > 0){
#                         j <- 1
#                         print(j)
#                     }
#
#                 }
#
#               }
#               # Change to a new non-negative value
# }




# print(self_reviews)





# print(self_review)

# size <- my_data[c(2)]
# complexity <- my_data[c(3)]
# change_churn <- my_data[c(4)]

# round(res, 2)
# model1 <- glm(result ~ size * complexity, binomial)
# summary(model1)

# spearman_correlation = cor(data, use="all.obs", method="spearman" )
# spearman_correlation = cor(data, use="complete.obs", method="spearman")
# print(spearman_correlation)