## Logistic Regression (binary classification)

library(tidyverse)
library(caret)
library(readr)


# load dataset
churn <- read_csv("churn.csv")
View(churn)


# explore dataset
glimpse(churn)


# Find Missing Value
mean(complete.cases(churn)) # ถ้าเท่ากับ 1 แปลว่า Data ไม่มี Missing value


## Step 1 split data

# build function
train_test_split <- function(churn, size=0.8) {
  set.seed(42)
  n <- nrow(churn)
  train_id <- sample(1:n, size*n)
  train_df <- churn[train_id, ]
  test_df <- churn[-train_id, ]
  return( list(train_df, test_df) )
}

train_test_split(churn)

prep_df <- train_test_split(churn, size=0.8)
prep_df[[1]] # training data
prep_df[[2]] # testing data


## Step 2 train model

set.seed(42)

ctrl <- trainControl(method = "cv", number = 10)

model <- train(churn ~ numbercustomerservicecalls + totalintlcharge + totalintlcalls + 
                 totalintlminutes + totalnightcharge,
               data = prep_df[[1]],
               method = "glm",
               trControl = ctrl)

## Step 3 score model

predict_churn <- predict(model, newdata = prep_df[[2]])


## Step 4 evaluate model

actual_churn <- prep_df[[2]]$churn

## confusion matrix
cm_churn <- confusionMatrix(predict_churn, factor(actual_churn))
