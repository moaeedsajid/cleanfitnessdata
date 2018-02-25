# cleansmartwatchdata
Coursera cleaning smartwatch data assignment

The original documentation about the Samsung smartphone project is available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data for this assignment was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This project runs the run_analysis.R script on files within the data folder 

From the source data we have placed the following files from UCI HAR Dataset into a single data folder to be used by the script

test\subject_test.txt
train\subject_train.txt
test\y_test.txt
train\y_train.txt
test\X_test.txt
train\X_train.txt
features.txt

The _test and _train in these files are the records of the 30 volunteers split across a test and training dataset.  This is a 30/70 split with 9 subjects in the test set and 21 in the training set.  This equates to 2947 observations in each test file and 7352 records in the training records.

The 2 subject files are a record of which subject each record refers to
The 2 y_ files list one of 6 activities for each record
The 2 X_ files are our 561 feature vector records

The content of each 2 files are added to each other (test first and then train) to make one long list of records with 10299 entries.  The script then completes the following objectives from the Coursera assignment.

1 - Merges the training and the test sets to create one data set
2 - Extracts only the measurements on the mean and standard deviation for each measurement (X_ files) reducing our 561 feature record down to 86 features
3 - Uses descriptive activity names to name the activities in the data set (manually taken from activity_labels.txt)
4 - Appropriately labels the data set with descriptive variable names (uses features.txt)
5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

The step 5 tidy dataset is saved as tidydataset.txt and uploaded as part of the assignment directly to Coursera.

Further details are available in codebook.md 

# Citations for the original data set :
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.



