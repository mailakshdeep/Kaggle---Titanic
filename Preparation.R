library(readr)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(mice)
library(randomForest)
library(caret)

titanictrain <- read_csv("C:/Users/AKS/Desktop/Kaggle/Titanic/train.csv") # importing training set
titanictest <- read_csv("C:/Users/AKS/Desktop/Kaggle/Titanic/test.csv")   # importing test set

titanic=bind_rows(titanictrain,titanictest)  # combining train and test datasets

View(titanic)