### Getting and Cleaning Data Course Project

The R script, `run_analysis.R`, does the the following as required by the project:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

As mentioned the `run_analysis.R` when run will download the required data, read the data, transform the data finally produce the end result `tidydata.txt` in the working directory. This file had been uploaded along with the `run_analysis.R` and is the only script needed to achieve the end result.

The `CodeBook.md` tries to explain in a little more detail the data transformations and variables used in the transformation.
