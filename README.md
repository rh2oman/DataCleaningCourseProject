# Readme.md - Getting and Cleaning Data — Course Project
This file provides the following: 1) The assignment details, 2) An explanation for variable selection, and 3) An overview of the R-script (run_analysis.R) used to create the tidy data file.
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
## R-Script (run_analysis.R)
The R-script section provides an explanation of the different parts of the run_analysis.R script. The discussion is broken down into the following subsections: 1) Selecting mean and standard deviation variables 2) Loading and the activity data, 3) Loading activity types and subject data, and 4) building and writing the tidy data file.<br /><br/>
### 1) Selecting Mean and Standard Deviation Variables
The features.txt file was used to determine what variables to select. A data table was created containing the variable number and name. Grep was then used to identify the variables that included mean and std in the variable name and a list of the those variable numbers was created.<br /><br/>
A list of the variable names was also created. The variable names where then altered using to make them more readable using the sub command.<br /><br/>
### 2) Loading Activity Data
The activity data from the train_X and test_X data sets were each loaded into separate dataframes. The variables to load where specified using the the variable number list build using the information in the features.txt file. The rows of the two dataframes were then combined into a single dataframe using the rbind command.<br /> 
<br />   
### 2) Loading Activity Types and Subject Data
The activity types data from the train_y and test_y data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command. The dataframe column name was then renamed to “activity_type” using in the name command.<br />
<br />
Next, the numeric indicators where converted to words. To do so, “activity_type” was first converted from numeric to character. Then, 1 was converted to ”Walking”, 2 was converted to "WalkingUpstairs” 3 was converted to ”WalkingDownstairs" 4 was converted to ”Sitting” 5 was converted to "Standing" and 6 was converted to "Laying”.<br />
<br />
Next, the subject data from the train_sub and test_sub data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command.The dataframe column name was then renamed to “subject” using in the name command.<br />
<br />
The cbind command was then used to create a complete_data dataframe. The cbind command binds the columns from the subject, activity_type, and activity dataframes.<br />
<br />
### 3) Building and Writing Tidy Data File.
To create the tidy data file the “subject” and “activity_type” variables in the complete_data dataframe were first changed to factors. The melt function was then used to transpose the dataframe into four columns including: subject, activity_type, variable name, and the value. The dcast function was then used to build the end product with subject, activity and each individual variable forming the columns. The mean of the values by subject and activity is the recorded value.<br /> <br />
Before writing the tidy data the original variable names were changed to indicate that the values are the means of the recorded scores.<br /><br />
Finally, the write.table command is used to create the output file.

