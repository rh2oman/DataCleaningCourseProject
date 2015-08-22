# Readme.md - Getting and Cleaning Data — Course Project


## Variable Selection Discussion

## R-Script Discussion
This section provides an explanation of the different parts of the R-script. The discussion is broken down into the following subsections: 1) Loading and Subsetting Activity Data; 2) Loading Training Activities and Subjects; and 3) Build and Write Tidy Data.
# 1) Loading and Subsetting Activity Data
Data from the train_X and test_X data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command.<br /> 
<br />
The resulting dataframe was then subsetted based on the variable selection criteria discussed above. The column number used to code the subset are found in the features.txt file provided in the assignment. <br />
<br />
The dataframe column names where then modified to make them more readable using the names command.<br />   
# 2) Loading Training Activities and Subjects
Data from the train_y and test_y data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command. The dataframe column name was then renamed to “activity_type” using in the name command.<br />
<br />
Next, ten the numeric indicators where converted to words. To do so, “activity_type” is first converted from numeric to character. Then, 1 is converted to ”WALKING”, 2 is converted to "WALKING_UPSTAIRS" 3 is converted to ”WALKING_DOWNSTAIRS" 3 is converted to ”SITTING” 5 is converted to "STANDING" and 6 is converted to "LAYING”.<br />
<br />
Next, the R-script reads the data from the train_sub and test_sub data sets were each loaded into separate dataframes. The rows of the two dataframes were then combined into a single dataframe using the rbind command.The dataframe column name was then renamed to “subject” using in the name command.<br />
<br />
Lastly, cbind is used, creating a complete dataframe that binds the columns from the subject, activity_type, and activity dataframes.<br />
<br />
# 3) Build and Write Tidy Data.
The dplyr library is used to build the tidy data set. <br />
<br />
To create the tidy data dataframe, the “subject” and “activity_type” variables in the complete dataframe are grouped using the group_by command. The summarize command is then applied using the newly created group and selecting the mean of each column in complete dataframe. <br />
<br />
Finally, the write.table command is used to create the output file.