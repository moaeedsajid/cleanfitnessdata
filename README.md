Coursera cleaning smartwatch data assignment

The original documentation about the Samsung smartphone project is available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data for this assignment was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For the data in this project the experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured. The experiments were  video-recorded to label the data manually. The obtained dataset had been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the dataset the following has been provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The actual complete data set was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## run_analysis.R

This script required the following 5 objectives...

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


From this source data we have placed the following files from UCI HAR Dataset into a single data folder to be used by the run_analysis.R script

- test\subject_test.txt
- train\subject_train.txt
- test\y_test.txt
- train\y_train.txt
- test\X_test.txt
- train\X_train.txt
- features.txt
- activity_labels.txt

There are 2947 observations in each test file and 7352 records in the training records.

It was determined that these files referenced...

- The 2 subject files are a record of which subject each record refers to as a numeric reference
- The 2 y_ files list one of the 6 activities for each record as a numeric reference
- The 2 X_ files are our 561 feature vector records

The run_analysis script performs the following...

##### Initialization

Any existing environment values are cleared
datadir is assigned to the "./data/" folder to be able to read the files
        
Data files are read into R using read.table and each of the test and training results are combined
        
subjects equals subject_test.txt and subject_train.txt
activity equals y_test.txt and y_train.txt
data equals X_test and X_train.txt
        
As each dataset is read in and combined the redundant data set is cleared for efficiency in processing the script

features.txt is read in using read.delim command. colClasses was set to NULL and character so only the second column is imported and sep set to "".  There was a single blank entry showing so the was set to NA and then cleared.  We were left with a single vector of data column names (datacolnames)
       
##### Objective 1 - Merging the complete data set

Our three data sets are merged using bind_cols to create a single merged_data entry.  It is important to keep the order of subjects, activity and data as these columns are referenced later
        
Our three now redundant data sets subjects, activity, data are cleared for efficiency

##### Objective 2 - Filtering dataset so we only have the mean and sd for each meauserment

From datacolnames we identify all columns with mean, Mean or std in their name so we only have mean and sd measurements.  This result gives us a numeric vector of all the columns we need.  As our merged_data dataset includes subject and activity as the first 2 columns these are added back in as 1 and 2 and the rest are moved along by adding 2 to each one.  This resultant filteredcols value is then used to create a subset of our original merged_data dataset creating a new filtered_data dataset.

This new data set has reduced our original 561 features from the X_ files to 86 values.  We still have 10299 observations.

merged_data set is no longer required so removed for efficiency.

##### Objective 3 - Add descriptive activity names by replacing the values in the second "Activity" column

Column 2 in filtered_data refers to the activity the user was doing at the time of the test.  This is currently set numerically 1 through to 6 but we have been asked to set descriptive activity names.

The activity_labels.txt was used and the recode command to set the values as follows...

1. Walking
2. Walking Upstairs
3. Walking Downstairs
4. Sitting
5. Standing
6. Laying


##### Objective 4 - The column names need to be set and our 86 data columns given more descriptive names

Column names are set with Subject, Activity and then the 86 filtered data column names

The gsub command was then used on the column names to replace nondescript text with more meaning. So...

* Entry beginning t with Time
* (t with  Time
* Entry begining f with Frequency
* -std() with Standard Deviation 
* -mean() with Mean
* Acc with Acceleration
* Gyro with Gyroscope
* Mag with Magnitude
* Jerk with Jerk
* (X with along the X axis
* (Y with along the Y axis
* (Z with along the Z axis
* -X with along the X axis
* -Y with along the Y axis
* -Z with along the Z axis
* -meanFreq() with mean Frequency
* JerkMean) with Jerk Mean
* gravityMean) with Gravity Mean
* gravity) with Gravity

datacolnames, filteredcols, filtereddatacols, filtereddatacolnames, variablenames no longer required so removed for efficiency

##### Objective 5 - Tidy data set with average for each subject and activity

A tidydataset was created from the filtered_data in step 4 by grouping the subject and activity values and then used summarize_all to calculate a mean for the 86 data entries for each record.  Looking at Hadley Wickham tidy data set document at https://www.jstatsoft.org/article/view/v059i10/v59i10.pdf

In tidy data:

1. Each variable forms a column.
Subject, activity and the 86 date entries have their own column

2. Each observation forms a row.
Each subject and the activity they perform for the test has it's own row

3. Each type of observational unit forms a table
We have one single table for the observations performed in the original experiment

This dataset is output to tidydataset.txt to be sumbitted for the assigment and can be read back in via the following command...

data <- read.table("tidydataset.txt",header=TRUE)

# Citations for the original experiment :
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.



