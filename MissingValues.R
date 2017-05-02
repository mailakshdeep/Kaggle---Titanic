summary(titanic)

# Count of missing values
# Fare - 1
# Embarked - 2
# Age  - 263

#   Missing Fare

sum(is.na(titanic$Fare))
pcl<-titanic[which(is.na(titanic$Fare)),]$Pclass
pcl           # Missing Fare is of Pclass 3
      
fillfare<-mean(titanic[!is.na(titanic$Fare) & titanic$Pclass==pcl,]$Fare)
fillfare      # Filling missing Fare with mean of Fare of Travellers of Pclass 3

titanic[is.na(titanic$Fare),]$Fare=fillfare  # Mean = 13.30289
sum(is.na(titanic$Fare))


#   Missing Embarked

sum(is.na(titanic$Embarked))
titanic[is.na(titanic$Embarked),]
titanic[is.na(titanic$Embarked),]$Fare   #  Both missing Embarked values had Fare 80

#   Plotting a Boxplot Fare corresponding Embarked to get the Embarking variable most probable to get Fare 80

plot=ggplot(titanic[!is.na(titanic$Embarked),], aes(x = Embarked, y = Fare, fill = factor(Pclass))) +
     geom_boxplot() +
     geom_hline(aes(yintercept=80), colour='red', linetype='dashed', lwd=2) +
     theme_few()

titanic[is.na(titanic$Embarked),]$Embarked='C'
sum(is.na(titanic$Embarked))

# Missing Age using mice package

sum(is.na(titanic$Age))
md.pattern(titanic)

# Better visualisation of missing values
library(VIM)
aggr_plot=aggr(titanic, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))

temp_titanic=mice(titanic[,!names(titanic) %in% c('PassengerId','Name','Ticket','Cabin','FamilySize','Surname','Survived')],method = "rf",m=5,maxit = 50,seed=502)
complete_titanic=complete(temp_titanic)

# To see if the imputed values has the same distribution as the original
densityplot(temp_titanic)
par(mfrow=c(1,2))
hist(titanic$Age,freq=F,col="Red")
hist(complete_titanic$Age,freq=F,col="Blue")

titanic$Age=complete_titanic$Age
sum(is.na(titanic$Age))