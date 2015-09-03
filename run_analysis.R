## set working directory
setwd("/Users/waterman/Documents/Data Science Courses/Getting and Cleaning Data/Project")

## load libraries
library (data.table)
library (dplyr)
library (reshape2)

## features.txt file to findout what variables to load
features <- read.table("./UCI HAR Dataset/features.txt" ,stringsAsFactors = FALSE)
## set the names of the features table
names(features) <- c("variableNum", "variableName")

## find variables that are means and standard deviations with grep
## place the names of these variables into meanStdVariables dataframe
meanStd_variables<-grep("mean\\(\\)|std\\(\\)",features[,2])
meanStd_variables_names <- features[meanStd_variables,2]

## modify variable names
## substitue t with time and f with frequency
meanStd_variables_names = sub('tBody', 'timeBody', meanStd_variables_names)
meanStd_variables_names = sub('tGravity', 'timeGravity', meanStd_variables_names)
meanStd_variables_names = sub('fBody', 'freqBody', meanStd_variables_names)
meanStd_variables_names = sub('fGravity', 'freqGravity', meanStd_variables_names)
## substitute -mean() with Mean and -std() with Std
meanStd_variables_names = sub('-mean', 'Mean', meanStd_variables_names)
meanStd_variables_names = sub('-std', 'Std', meanStd_variables_names)
## substitute Acc with Accelerometer, Mag with Magnitude and Gyro with Gyroscope
meanStd_variables_names = sub('Acc', 'Accelerometer', meanStd_variables_names)
meanStd_variables_names = sub('Mag', 'Magnitude', meanStd_variables_names)
meanStd_variables_names = sub('Gyro', 'Gyroscope', meanStd_variables_names)
## set axis 
meanStd_variables_names = sub('X', 'Xaxis', meanStd_variables_names)
meanStd_variables_names = sub('Y', 'Yaxis', meanStd_variables_names)
meanStd_variables_names = sub('Z', 'Zaxis', meanStd_variables_names)
## remove () and bodyBody
meanStd_variables_names <- sub('[-()]', '', meanStd_variables_names)
meanStd_variables_names <- sub('BodyBody', 'Body', meanStd_variables_names)


## Read the columns specified in the meanStdVariables dataframe from the 
## training and test Activity datasets into dataframes
train_X <- read.table ("./UCI HAR Dataset/train/X_train.txt", header=F, fill=T)[meanStd_variables]
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F, fill=T)[meanStd_variables]

## Merge train and test Activity Type datasets together into one dataframe
## rbind combineds the rows of the dataframes together
meanStd <- rbind(train_X, test_X)

## Rename the columns in the meanStd dataframe to something easier to understand
names(meanStd) <- c(meanStd_variables_names)

## Read the test and training activity type datasets into dataframes
train_y <- read.table ("./UCI HAR Dataset/train/y_train.txt", header=F, fill=T)
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F, fill=T)

## merge the activity type dataframes together
train_test_y <- rbind(train_y, test_y)

## rename column to activity type
names(train_test_y) <- c("activity_type")

## Convert from numeric indicators to words.
## First convert from numeric to character type
train_test_y$activity_type <- as.character(train_test_y$activity_type)
## Second reset each activity type with the words instead of code number.
train_test_y$activity_type[train_test_y$activity_type == "1"] <- "Walking"
train_test_y$activity_type[train_test_y$activity_type == "2"] <- "WalkingUpstairs"
train_test_y$activity_type[train_test_y$activity_type == "3"] <- "WalkingDownstairs"
train_test_y$activity_type[train_test_y$activity_type == "4"] <- "Sitting"
train_test_y$activity_type[train_test_y$activity_type == "5"] <- "Standing"
train_test_y$activity_type[train_test_y$activity_type == "6"] <- "Laying"

## Read the test and training Subject datasets into dataframes
train_sub <- read.table ("./UCI HAR Dataset/train/subject_train.txt", header=F, fill=T)
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F, fill=T)

## Merge train and test Subject datasets together into one dataframe
## combineds the rows of the dataframes together
train_test_sub <- rbind(train_sub, test_sub)

## rename column to subject
names(train_test_sub) <- c("subject")

## Create a new dataframe that binds the merged testing and training data with activity type and subject
## combined the column from the one dataframe to the second dataframe
combined_data <- cbind(train_test_sub, train_test_y, meanStd)

## building the final tidy dataset 
## convert activity_type and subject to a factor
combined_data$activity_type<-factor(combined_data$activity_type)
combined_data$subject<-as.factor(combined_data$subject)
## melt combined data to long format
combined_data_melt<-melt(combined_data,id = c("subject","activity_type"))
combined_data_melt$value<-as.numeric(combined_data_melt$value)

##calculate the mean of each variable for each subject and activity_type
combined_data_mean <-dcast(combined_data_melt,subject + activity_type ~ variable, mean)

## build new list of variable names for tidy dataset
tidy_variables_names <- meanStd_variables_names
## rename columns for accuracy
tidy_variables_names = sub('time', 'meanOfTime', tidy_variables_names)
tidy_variables_names = sub('freq', 'meanOfFreq', tidy_variables_names)

## Rename the columns in the combined_data_mean dataframe to something easier to understand
names(combined_data_mean) <- c("subject", "activityType", tidy_variables_names)

## write text output 
write.table(combined_data_mean, file = "./courseproject.txt", row.name=FALSE)