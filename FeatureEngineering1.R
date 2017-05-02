titanic$Surname=gsub('(,.*)','',titanic$Name)               # New feature Surname

titanic$Title=gsub('(.*, )|(\\..*)','',titanic$Name)        # New feature Title
table(titanic$Title)

titanic[titanic$Title %in% c("Ms","Mlle"),]$Title="Miss"    # Combining titles belonging to same class
table(titanic$Title)

titanic[!(titanic$Title %in% c("Miss","Mr","Mrs","Master")),]$Title="Special"  # Combining unique titles into one class
table(titanic$Title)

titanic$FamilySize=titanic$SibSp+titanic$Parch+1            # New feature Family Size

factor_vars <- c('PassengerId','Pclass','Sex','Embarked',
                 'Title','Survived')

titanic[factor_vars] <- lapply(titanic[factor_vars], function(x) as.factor(x))

str(titanic)

View(titanic)