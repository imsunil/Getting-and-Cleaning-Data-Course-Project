# Code Book

This document describes the some of the varibles  and the data transformation carried out by the submitted `run_analysis.R` in order to achieve the desired result per the problem statment.


### Structure of the R Script

The code in the R script is laid down in the following order of required activities:

##### A. Merges the training and the test sets to create one data set.

1. Download and extract data 
    + Download the zipped data to a folder called samsungdata
    + Extract file and set the working directory to `basefilepath<-file.path(".","samsungdata","UCI HAR Dataset")`.
2. Read Data
    + Read the test, train with subject and activity and transform to get `testdatacomplete` and `traindatacomplete` variables
    + Read activity descriptions and features in to `activitydesc` and `features` variables.
3. Combine read data to get `fulldataset`.

##### B. Extracts only the measurements on the mean and standard deviation for each measurement. 

4. Determine the required columns for mean() and std() in to `reqfeaturenames` and add the subject and activity colummns to get `allfeaturenames`.
5. subset the data to get the required data using `reqdata<-subset(fulldataset,select=allfeaturenames)`.

##### C. Uses descriptive activity names to name the activities in the data set
##### D. Appropriately labels the data set with descriptive variable names.  

6.Rename some variables to more descreptive format and other cleanup.
  * `names(reqdata)<-gsub("^t","time",names(reqdata))`
  * `names(reqdata)<-gsub("^f","frequency",names(reqdata))`
  * `names(reqdata)<-gsub('[()]','',names(reqdata))`
  * `names(reqdata)<-gsub("BodyBody","Body",names(reqdata))`
7. Set up activity as factor using labels from activity description.
    `reqdata$activity<-factor(reqdata$activity,levels=activitydesc[,1],labels=activitydesc[,2])`
    
##### E. From the data set in step D, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

8. Factorize some variable and get average in the `melteddatamean` variable.
9. Create the tidydata.txt from the melted data.

