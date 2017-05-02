# Split the data into train set and a test set

train=titanic[1:891,]
test=titanic[-(1:891),]

# Logistic Regression

glm.fit=glm(factor(Survived)~Pclass+Sex+Age+Embarked+SibSp+Parch+Fare+FamilySize+Child+Title,train,family = binomial,maxit=100)
summary(glm.fit)
pred=predict(glm.fit,test,type = "response")
glm.pred=rep(0,418)
glm.pred[pred>0.5]=1
glm.solution <- data.frame(PassengerID = test$PassengerId, Survived = glm.pred)
glm.solution
write.csv(file = "GLMSolution.csv",glm.solution,row.names = F)

# Random Forest

rf.fit=randomForest(factor(Survived)~Pclass+Sex+Age+Embarked+SibSp+Parch+Fare+FamilySize+Child+Title,train,importance=TRUE)
summary(rf.fit)
rf.pred=predict(rf.fit,test)
rf.solution <- data.frame(PassengerID = test$PassengerId, Survived = rf.pred)
rf.solution
write.csv(file = "RFSolution.csv",rf.solution,row.names = F)
