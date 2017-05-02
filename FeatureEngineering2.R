# Creating new features from the imputed missing values 

titanic$Child[titanic$Age>=18]=0      
titanic$Child[titanic$Age<18]=1
titanic$Child=as.factor(titanic$Child)   # New feature Child which indicate whether or not is the person a child

