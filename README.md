# Readme.md - Getting and Cleaning Data — Course Project
This file provides the following: 1) The assignment details, 2) An explanation for variable selection, and 3) An overview of the R-script used to create the tidy data file.
## Assignment Details
The assignment details section provides the background for the assignment. The original text can be found at  https://class.coursera.org/getdata-031/human_grading/view/courses/975115/assessments/3/submissions <br />
<br >
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.<br />  
<br />
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: <br />
<br />
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones <br /> 
<br />
Here are the data for the project: <br /> 
<br />
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip <br />
<br />
You should create one R script called run_analysis.R that does the following.<br />
1. Merges the training and the test sets to create one data set. <br />
2. Extracts only the measurements on the mean and standard deviation for each measurement. <br />
3. Uses descriptive activity names to name the activities in the data set <br />
4. Appropriately labels the data set with descriptive variable names. <br />
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variable Selection
The variable selection section discusses the variable selection for the final tidy data file. As stated in the assignment instructions above, only the measurements on the mean and stand deviation for each measurement be used when creating the tidy data file. Moreover, the tidy data file is to include the “average of each variable for each activity.”  <br />
<br />
There are multiple ways in which “only the measurements on the mean and stand deviation for each measurement” might be defined. To duplicate results the following rules should be applied when selecting mean and standard deviation variables. Variable names are found in the features.txt file.<br />
1. Variable names include either mean or std. <br />
2. Variable names do not include angle. <br />
<br />
The angle variables were excluded. Based on the information in the features_info.txt file, these variables deal with the angle between variables. For the tidy data set it was decided that just the time, magnitude and frequency of measurements along the x, y and z axial dimensions would be included.
## R-Script
The R-script section provides an explanation of the different parts of the R-script. The discussion is broken down into the following subsections: 1) Loading and Subsetting Activity Data, 2) Loading Training Activities and Subjects, and 3) Build and Write Tidy Data.
### 1) Loading and Subsetting Activity Data
Data from the train_X and test_X data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command.<br /> 
<br />
The resulting dataframe was then subsetted based on the variable selection criteria discussed above. The column number used to code the subset are found in the features.txt file provided in the assignment. <br />
<br />
The dataframe column names where then modified to make them more readable using the names command.<br />   
### 2) Loading Training Activities and Subjects
Data from the train_y and test_y data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command. The dataframe column name was then renamed to “activity_type” using in the name command.<br />
<br />
Next, ten the numeric indicators where converted to words. To do so, “activity_type” is first converted from numeric to character. Then, 1 is converted to ”WALKING”, 2 is converted to "WALKING_UPSTAIRS" 3 is converted to ”WALKING_DOWNSTAIRS" 3 is converted to ”SITTING” 5 is converted to "STANDING" and 6 is converted to "LAYING”.<br />
<br />
Next, the R-script reads the data from the train_sub and test_sub data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command.The dataframe column name was then renamed to “subject” using in the name command.<br />
<br />
Lastly, cbind is used, creating a complete dataframe that binds the columns from the subject, activity_type, and activity dataframes.<br />
<br />
### 3) Build and Write Tidy Data.
The dplyr library is used to build the tidy data set. <br />
<br />
To create the tidy data dataframe, the “subject” and “activity_type” variables in the complete dataframe are grouped using the group_by command. The summarize command is then applied using the newly created group and selecting the mean of each column in complete dataframe. <br />
<br />
Finally, the write.table command is used to create the output file.

