setwd("/Users/waterman/Documents/Data Science Courses/Getting and Cleaning Data/Project")

## Read the test and training Activity Type datasets into dataframes
train_X <- read.table ("./UCI HAR Dataset/train/X_train.txt", header=F, fill=T)
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F, fill=T)

## Merge train and test Activity Type datasets together into one dataframe
## rbind combineds the rows of the dataframes together
train_test_X <- rbind(train_X, test_X)

## Subset with only means and standard deviations
## Using variable name and position from features.txt to select columns to keep
## See README.txt for more detail
mean_std_X <- train_test_X[c(1:6,41:46,81:86,121:126,161:166,201:202,
                             214:215,227:228,240:241,253:254,266:271,
                             345:350,424:429,503:504,516:517,529:530,
                             542:543)]

## Rename the columns in the mean_std_X dataframe to something that is easier to understand the meaning of
names(mean_std_X) <- c("xaxisBodyAccelerometerMean", "yaxisBodyAccelerometerMean", "zaxisBodyAccelerometerMean",
                       "xaxisBodyAccelerometerStd", "yaxisBodyAccelerometerStd", "zaxisBodyAccelerometerStd",
                       "xaxisGravityAccelerometerMean", "yaxisGravityAccelerometerMean", "zaxisGravityAccelerometerMean",
                       "xaxisGravityAccelerometerStd", "yaxisGravityAccelerometerStd", "zaxisGravityAccelerometerStd",
                       "xaxisBodyAccelerometerJerkMean", "yaxisBodyAccelerometerJerkMean", "zaxisBodyAccelerometerJerkMean",
                       "xaxisBodyAccelerometerJerkStd", "yaxisBodyAccelerometerJerkStd", "zaxisBodyAccelerometerJerkStd",
                       "xaxisBodyGyroscopeMean", "yaxisBodyGyroscopeMean","zaxisBodyGyroscopeMean",
                       "xaxisBodyGyroscopeStd", "yaxisBodyGyroscopeStd", "zaxisBodyGyroscopeStd",
                       "xaxisBodyGyroscopeJerkMean", "yaxisBodyGyroscopeJerkMean", "zaxisBodyGyroscopeJerkMean",
                       "xaxisBodyGyroscopeJerkStd", "yaxisBodyGyroscopeJerkStd", "zaxisBodyGyroscopeJerkStd",
                       "bodyAccelerometerMagnitudeMean", "bodyAccelerometerMagnitudeStd",
                       "gravityAccelerometerMagnitudeMean", "gravityAccelerometerMagnitudeStd",
                       "bodyAccelerometerJerkMagnitudeMean", "bodyAccelerometerJerkMagnitudeStd",
                       "bodyGyroscopeMagnitudeMean", "bodyGyroscopeMagnitudeStd",
                       "bodyGyroscopeJerkMagnitudeMean", "bodyGyroscopeJerkMagnitudeStd",
                       "freqxaxisBodyAccelerometerMean", "freqyaxisBodyAccelerometerMean", "freqzaxisBodyAccelerometerMean",
                       "freqxaxisBodyAccelerometerStd", "freqyaxisBodyAccelerometerStd", "freqzaxisBodyAccelerometerStd",
                       "freqxaxisBodyAccelerometerJerkMean", "freqyaxisBodyAccelerometerJerkMean", "freqzaxisBodyAccelerometerJerkMean",
                       "freqxaxisBodyAccelerometerJerkStd", "freqyaxisBodyAccelerometerJerkStd", "freqzaxisBodyAccelerometerJerkStd",
                       "freqxaxisBodyGyroscopeMean", "freqyaxisBodyGyroscopeMean", "freqzaxisBodyGyroscopeMean",
                       "freqxaxisBodyGyroscopeStd", "freqyaxisBodyGyroscopeStd", "freqzaxisBodyGyroscopeStd",
                       "freqBodyAccelerometerMagnitudeMean", "freqBodyAccelerometerMagnitudeStd",
                       "freqBodyAccelerometerJerkMagnitudeMean", "freqBodyAccelerometerJerkMagnitudeStd",
                       "freqBodyGyroscopeMagnitudeMean", "freqBodyGyroscopeMagnitudeStd",
                       "freqBodyGyroscopeJerkMagnitudeMean", "freqBodyGyroscopeJerkMagnitudeStd"
                      )

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
train_test_y$activity_type[train_test_y$activity_type == "1"] <- "WALKING"
train_test_y$activity_type[train_test_y$activity_type == "2"] <- "WALKING_UPSTAIRS"
train_test_y$activity_type[train_test_y$activity_type == "3"] <- "WALKING_DOWNSTAIRS"
train_test_y$activity_type[train_test_y$activity_type == "4"] <- "SITTING"
train_test_y$activity_type[train_test_y$activity_type == "5"] <- "STANDING"
train_test_y$activity_type[train_test_y$activity_type == "6"] <- "LAYING"

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
combined_data <- cbind(train_test_sub, train_test_y, mean_std_X)

## building the final tidy dataset using dplyr and summarize
library(dplyr)
## Make an Activity group using the Activity_Type
## Subject <- group_by(combined_data, Subject)
activity <- group_by(combined_data, subject, activity_type)
## create the final tidy data set using the summarize command the activity group
## provides a new name for each column denoting it is the mean of the original column
final_data <- summarize(activity, meanXaxisBodyAccelerometerMean = mean(xaxisBodyAccelerometerMean), 
                                  meanYaxisBodyAccelerometerMean = mean(yaxisBodyAccelerometerMean), 
                                  meanZaxisBodyAccelerometerMean = mean(zaxisBodyAccelerometerMean),
                                  meanXaxisBodyAccelerometerStd = mean(xaxisBodyAccelerometerStd), 
                                  meanYaxisBodyAccelerometerStd = mean(yaxisBodyAccelerometerStd), 
                                  meanZaxisBodyAccelerometerStd = mean(zaxisBodyAccelerometerStd),
                                  meanXaxisGavityAccelerometerMean = mean(xaxisGravityAccelerometerMean), 
                                  meanYaxisGravityAccelerometerMean = mean(yaxisGravityAccelerometerMean), 
                                  meanZaxisGravityAccelerometerMean = mean(zaxisGravityAccelerometerMean),
                                  meanXaxisBravityAccelerometerStd = mean(xaxisGravityAccelerometerStd),
                                  meanYaxisGravityAccelerometerStd = mean(yaxisGravityAccelerometerStd),
                                  meanZaxisGravityAccelerometerStd = mean(zaxisGravityAccelerometerStd),
                                  meanXaxisBodyAccelerometerJerkMean = mean(xaxisBodyAccelerometerJerkMean),
                                  meanYaxisBodyAccelerometerJerkMean = mean(yaxisBodyAccelerometerJerkMean), 
                                  meanZaxisBodyAccelerometerJerkMean = mean(zaxisBodyAccelerometerJerkMean),
                                  meanXxisBodyAccelerometerJerkStd = mean(xaxisBodyAccelerometerJerkStd),
                                  meanYaxisBodyAccelerometerJerkStd = mean(yaxisBodyAccelerometerJerkStd),
                                  meanZaxisBodyAccelerometerJerkStd = mean(zaxisBodyAccelerometerJerkStd),
                                  meanXaxisBodyGyroscopeMean = mean(xaxisBodyGyroscopeMean),
                                  meanYaxisBodyGyroscopeMmean = mean(yaxisBodyGyroscopeMean),
                                  meanZaxisBodyGyroscopeMean = mean(zaxisBodyGyroscopeMean),
                                  meanXaxisBodyGyrosopeStd = mean(xaxisBodyGyroscopeStd),
                                  meanYaxisBodyGyrocopeStd = mean(yaxisBodyGyroscopeStd),
                                  meanZaxisBodyGyroscopeStd = mean(zaxisBodyGyroscopeStd),
                                  meanXaxisBodyGyroscopeJerkMean = mean(xaxisBodyGyroscopeJerkMean), 
                                  meanYaxisBodyGyroscopeJerkMean = mean(yaxisBodyGyroscopeJerkMean),
                                  meanZaxisBodyGyroscopeJerkMean = mean(zaxisBodyGyroscopeJerkMean),
                                  meanXaxisBodyGyroscopeJerkStd = mean(xaxisBodyGyroscopeJerkStd),
                                  meanYaxisBodyGyroscopeJerkStd = mean(yaxisBodyGyroscopeJerkStd),
                                  meanZaxisBodyGyroscopeJerkStd = mean(zaxisBodyGyroscopeJerkStd),
                                  meanBodyAccelerometermag_mean = mean(bodyAccelerometerMagnitudeMean),
                                  meanBodyAccelerometermag_std = mean(bodyAccelerometerMagnitudeStd),
                                  meanGravityAccelerometerMagnitudeMean = mean(gravityAccelerometerMagnitudeMean),
                                  meanGravityAccelerometerMagnitudeStd = mean(gravityAccelerometerMagnitudeStd),
                                  meanBodyAccelerometerJerkMagnitudeMean = mean(bodyAccelerometerJerkMagnitudeMean),
                                  meanBodyAccelerometerJerkMagnitudeStd = mean(bodyAccelerometerJerkMagnitudeStd),
                                  meanBodyGyroscopeMagnitudeMean = mean(bodyGyroscopeMagnitudeMean),
                                  meanBodyGyroscopeMagnitudeStd = mean(bodyGyroscopeMagnitudeStd),
                                  meanBodyGyroscopeJerkMagnitudeMean = mean(bodyGyroscopeJerkMagnitudeMean),
                                  meanBodyGyroscopeJerkMagnitudeStd = mean(bodyGyroscopeJerkMagnitudeStd),
                                  meanFreqxaxisBodyAccelerometerMean = mean(freqxaxisBodyAccelerometerMean),
                                  meanFreqyaxisBodyAccelerometerMean = mean(freqyaxisBodyAccelerometerMean),
                                  meanFreqzaxisBodyAccelerometerMean = mean(freqzaxisBodyAccelerometerMean),
                                  meanFreqxaxisBodyAccelerometerStd = mean(freqxaxisBodyAccelerometerStd),
                                  meanFreqyaxisBodyAccelerometerStd = mean(freqyaxisBodyAccelerometerStd),
                                  meanFreqzaxisBodyAccelerometerStd = mean(freqzaxisBodyAccelerometerStd),
                                  meanFreqxaxisBodyAccelerometerJerkMean = mean(freqxaxisBodyAccelerometerJerkMean),
                                  meanFreqyaxisBodyAccelerometerJerkMean = mean(freqyaxisBodyAccelerometerJerkMean),
                                  meanFreqzaxisBodyAccelerometerJerkMean = mean(freqzaxisBodyAccelerometerJerkMean),
                                  meanFreqxaxisBodyAccelerometerJerkStd = mean(freqxaxisBodyAccelerometerJerkStd),
                                  meanFreqyaxisBodyAccelerometerJerkStd = mean(freqyaxisBodyAccelerometerJerkStd),
                                  meanFreqzaxisBodyAccelerometerJerkStd = mean(freqzaxisBodyAccelerometerJerkStd),
                                  meanFreqxaxisBodyGyroscopeMean = mean(freqxaxisBodyGyroscopeMean), 
                                  meanFreqyaxisBodyGyroscopeMean = mean(freqyaxisBodyGyroscopeMean),
                                  meanFreqzaxisBodyGyroscopeMean = mean(freqzaxisBodyGyroscopeMean),
                                  meanFreqxaxisBodyGyroscopeStd = mean(freqxaxisBodyGyroscopeStd),
                                  meanFreqyaxisBodyGyroscopeStd = mean(freqyaxisBodyGyroscopeStd),
                                  meanFreqzaxisBodyGyroscopeStd = mean(freqzaxisBodyGyroscopeStd),
                                  meanFreqBodyAccelerometerMagnitudeMean = mean(freqBodyAccelerometerMagnitudeMean),
                                  meanFreqBodyAccelerometerMagnitudeStd = mean(freqBodyAccelerometerMagnitudeStd),
                                  meanFreqBodyAccelerometerJerkMagnitudeMean = mean(freqBodyAccelerometerJerkMagnitudeMean),
                                  meanFreqBodyAccelerometerJerkMagnigudeStd = mean(freqBodyAccelerometerJerkMagnitudeStd),
                                  meanFreqBodyGyroscopeMagnitudeMean = mean(freqBodyGyroscopeMagnitudeMean),
                                  meanFreqBodyGyroscopeMagnitudeStd = mean(freqBodyGyroscopeMagnitudeStd),
                                  meanFreqBodyGyroscopeJerkMagnitudeMean = mean(freqBodyGyroscopejerkMagnitudeMean),
                                  meanFreqBodyGyroscopeJerkMagnitudeStd = mean(freqBodyGyroscopejerkMagnitudeStd))

## write text output 
write.table(final_data, file = "./courseproject.txt", row.name=FALSE)