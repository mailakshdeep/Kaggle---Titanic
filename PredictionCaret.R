# Split the data into train set and a test set

tran=titanic[1:891,]
test=titanic[-(1:891),]


fit.control=trainControl(method = "repeatedcv",number=5,repeats = 5)

# Logistic Regression

glm.fit=train(y=tran$Survived,x=tran[,c("Pclass","Sex","Age","Fare","FamilySize","Title","Embarked","SibSp","Parch","Child")],method="glm",trControl=fit.control)
print(glm.fit)

glm.pred=predict.train(glm.fit,test)
glm.solution <- data.frame(PassengerID = test$PassengerId, Survived = glm.pred)
glm.solution
write.csv(file = "GLMSolutionCaret.csv",glm.solution,row.names = F)


# Random Forest

rf.fit=train(y=tran$Survived,x=tran[,c("Pclass","Sex","Age","Fare","FamilySize","Title","Embarked","SibSp","Parch","Child")],method="rf",trControl=fit.control)
print(rf.fit)

rf.pred=predict.train(rf.fit,test)
rf.solution <- data.frame(PassengerID = test$PassengerId, Survived = rf.pred)
rf.solution
write.csv(file = "RFSolutionCaret.csv",rf.solution,row.names = F)



# Gradient Boosting Algorithm           

grid=expand.grid(n.trees=c(10,20,50,100,500,1000),shrinkage=c(0.01,0.05,0.1,0.5),interaction.depth=c(1,5,10),n.minobsinnode=c(3,5,10))
gbm.fit=train(y=tran$Survived,x=tran[,names(tran) %in% c("Pclass","Sex","Age","Fare","FamilySize","Title","Embarked","SibSp","Parch","Child")],method="gbm",trControl = fit.control,tuneGrid = grid)
print(gbm.fit)

gbm.pred=predict.train(gbm.fit,test)
gbm.solution <- data.frame(PassengerID = test$PassengerId, Survived = gbm.pred)
gbm.solution
write.csv(file = "GBMSolutionCaret.csv",gbm.solution,row.names = F)

