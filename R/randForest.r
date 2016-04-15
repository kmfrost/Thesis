set.seed(100)

setwd("D:/Documents/Github/Thesis/DataFiles")
trai <- read.csv("trai_norm_email_features_35_30_35.csv")
test <- read.csv("test_norm_email_features_35_30_35.csv")
pids <- subset(trai, select=c(pid))
trai <- subset(trai, select=-c(pid))
test <- subset(test, select=-c(Status))

rf <- randomForest(Status~., data=trai, ntree=500, sampsize=c(8,30,7,2,5,17))
pred <- predict(rf, test, type='prob')
confusionMatrix(pred, trai$Status)


