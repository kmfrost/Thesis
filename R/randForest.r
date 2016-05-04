
setwd("D:/Documents/Github/Thesis/DataFiles")
trai <- read.csv("trai_norm_email_features_35_30_35.csv")
test <- read.csv("test_norm_email_features_35_30_35.csv")
pids <- subset(trai, select=c(pid))
trai <- subset(trai, select=-c(pid))
test <- subset(test, select=-c(Status))

rf <- randomForest(Status~., data=trai, ntree=500, sampsize=c(8,30,7,2,5,17), strata=trai$Status)
pred <- predict(rf, test)
confusionMatrix(pred, trai$Status)

set.seed(10)
#loocv_data <- read.csv("trai_norm_email_features_100.csv")
loocv_data <- read.csv("LOOCV_1.csv")
loocv_data <- subset(loocv_data, select=-c(pid, Status))
result <- rfcv(loocv_data, trai$Status, cv.fold=67,ntree=500, classwt=c(8,30,7,2,5,17))
confusionMatrix(unlist(result$predicted['119']), trai$Status)
