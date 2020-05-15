setwd("ruta")

library(caret)
library(randomForest)
#install.packages("fields")
library(fields)

test.m <- read.csv("test.csv", sep = ",", header = T)
train.m <- read.csv("train.csv", sep = ",", header = T)

table(train.m[,c('var1', 'var2')])

# Converting &lsquo;Survived&rsquo; to a factor
train.m$Adap_Local <- factor(train.m$var1)
# Set a random seed
set.seed(51)

# Training using &lsquo;random forest&rsquo; algorithm
model.m <- train(var2 ~. ,
               data = train.m, 
               method = 'rf',
               trControl = trainControl(method = 'cv', 
                                        number = 5)) 
               
#Ahora si, prediciendo 
test.m$Diversidad <- predict(model.m, newdata = test.m)

write.csv(test.m, file = "Diversidad_FR.csv")
