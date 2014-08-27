install.packages("caret")
install.packages("rpart")
install.packages("tree")
install.packages("randomForest")
install.packages("e1071")
install.packages("ggplot2")

setwd('/home/cadu/Desktop/Coursera/DataScience/assignment5')
myData <- read.csv("seaflow_21min.csv")
summary(myData)

library(caret)
set.seed(3456)
inTrainingSet <- createDataPartition(myData$pop,p = 0.5,list=FALSE)
training <- myData[inTrainingSet,]
testing <- myData[-inTrainingSet,]
summary(seaflowTrain)

library(ggplot2)
p <- ggplot(myData, aes(x = chl_small, y = pe ) )
p + geom_line(aes(colour = pop))
ggplot(aes(x=chl_small,y=pe,color=pop),data=myData)+geom_jitter()

library(rpart)
fol <- formula(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small)
model_1 <- rpart(fol, method="class", data=training)
print(model_1)

install.packages('partykit')
library(partykit)

rpart1a <- as.party(model_1)

plot(rpart1a)
library(rpart.plot)
rpart.plot(model_1,branch=0,branch.type=2,type=1,extra=102,shadow.col="pink",box.col="gray",split.col="magenta")

predict_1=predict(model_1,newdata=testing)
str(predict_1)

pop_test_1=c()
pop_names=c("crypto","nano","pico","synecho","ultra")
for (i in 1:nrow(predict_1)){
  pop_test_1=c(pop_test_1,pop_names[which.max(predict_1[i,])])
} 
result_1=as.vector(testing$pop)==pop_test_1
table(result_1)

accuracy_1=sum(result_1)/length(pop_test_1)
predict_1c=predict(model_1,newdata=testing,type= "class")
table(predict_1c, testing$pop)

confusionMatrix(predict_1c, testing$pop)
install.packages("randomForest")
library(randomForest)

model_6 <- randomForest(fol, data=training)

predict_9c=predict(model_6,newdata=testing,type= "class")
table(predict_9c, testing$pop)
confusionMatrix(predict_9c, testing$pop)

importance(model_6)
library(e1071)
model_svm <- svm(fol, data=training)
