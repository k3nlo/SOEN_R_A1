# Title     : SOEN6611 Assignment1
# Objective : logisitc regression
# Created by: kenlo
# Created on: 2019-03-16

Sys.setenv(LANG = "en")

# file1 = 'Cassandra_CK/C3.11.0_CK.csv'
# file2 = 'Cassandra_CK/C3.11.1_CK.csv'

# file1 = 'Cassandra_CK/C3.11.3_CK.csv'
# file2 = 'Cassandra_CK/C3.11.4_CK.csv'

# file1 = 'Neo4J_CK/neo4j-3.4.1_CK.csv'
# file2 = 'Neo4J_CK/neo4j-3.4.6_CK.csv'

file1 = 'OrientDB_CK/2.2.21_CK.csv'
file2 = 'OrientDB_CK/2.2.30_CK.csv'


csvFile1 <- read.csv(file1, sep = ",", head=TRUE)
csvFile2 <- read.csv(file2, sep = ",", head=TRUE)

attach(csvFile1)
attach(csvFile2)
names(csvFile1)
names(csvFile2)

metric <- 'NOC'

csvFile1<-csvFile1[!(csvFile1$NOC=="n/a"),]
csvFile2<-csvFile2[!(csvFile2$NOC=="n/a"),]


# select all numerical values column
dataset_A <- csvFile1[c(2,3,4,5,6,7)]
dataset_B <- csvFile2[c(2,3,4,5,6,7)]

attach(dataset_A)
attach(dataset_B)
names(dataset_A)
names(dataset_B)

metric_data_A <- dataset_A[c(metric)]
metric_data_B <- dataset_B[c(metric)]


for(i in 1:length(metric_data_A)){
    metric_data_A[i] <- as.numeric(unlist(metric_data_A[i]))

}
for(i in 1:length(metric_data_B)){
    metric_data_B[i] <- as.numeric(unlist(metric_data_B[i]))

}

# print(head(wmc_3110, 20))
print(summary(metric_data_A))
# print(head(wmc_3111, 20))
print(summary(metric_data_B))

  set_0_row_count <- nrow(metric_data_A)
  # print(cat(sprintf('set 0 has ', set_0_row_count, ' rows' )))
  print(set_0_row_count)
  set_1_row_count <- nrow(metric_data_B)
  # print(cat(sprintf('set 1 has ', set_1_row_count, ' rows'  )))
  print(set_1_row_count)
#
#
  test_data_0 <- data.frame(
                version = rep(c("vA")),
                wmc = c(metric_data_A)
  )
  # test_data_0 <- test_data_0[complete.cases(test_data_0), ]
  # test_data_0 <- na.omit(test_data_0)
  test_data_1 <- data.frame(
                version = rep(c("vB")),
                wmc = c(metric_data_B)
  )
#
attach(test_data_0)
attach(test_data_1)
# # allow us to call the data in a column by its name
names(test_data_0)
names(test_data_1)

test_data_0[c(metric)] <- as.numeric(unlist(test_data_0[c(metric)]))
test_data_1[c(metric)] <- as.numeric(unlist(test_data_1[c(metric)]))

      # print(head(test_data_0, 20))
      # print(head(test_data_1, 20))
# combine them
test_data <- rbind(test_data_0, test_data_1)
   # print(head(test_data, 20))

attach(test_data)
names(test_data)

version <- test_data[c('version')]
wmc <- as.numeric(unlist(test_data[c(metric)]))

# # THESE WORK ONLY IN DIRECT R INTERACTIVE CONSOLE
# library(dplyr)
#     group_by(test_data, version) %>%
#       summarise(
#         count = n(),
#         median = median(wmc, na.rm = TRUE),
#         IQR = IQR(wmc, na.rm = TRUE)
#       )
#
# # Plot weight by group and color by group
# library("ggpubr")
# ggboxplot(test_data, x = "version", y = "wmc",
#           color = "version", palette = c("#00AFBB", "#E7B800"),
#           ylab = "wmc", xlab = "Versions")

vA_metric <- as.numeric(unlist(test_data_0[c(metric)]))
vB_metric<- as.numeric(unlist(test_data_1[c(metric)]))

test_result <- wilcox.test(vA_metric, vB_metric)
print(test_result)

# The p-value of the test is 0.02712, which is less than the significance level alpha = 0.05. We can conclude
# that men’s median weight is significantly different from women’s median weight with a p-value = 0.02712.