# run_analysis.R
# Getting and Cleaning data Coursera Project

# This script works on the following fitness data set 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 - Uses descriptive activity names to name the activities in the data set
# 4- Appropriately labels the data set with descriptive variable names.
# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Version 1.0 25 February 2018

# Load libraries
        library(readr)
        library(dplyr)

#Initialization

        # reset any existing environment values
        rm (list = ls())
        
        #Assign directory for data files
        datadir = "./data/"
        
        #Read the datafiles into R - Combine the test and training data for subjecs, activity and the data
        
        testsubjects <- read.table(file = paste(datadir,"subject_test.txt", sep = ""))
        trainsubjects <- read.table(file = paste(datadir,"subject_train.txt", sep = ""))
        subjects <- bind_rows(testsubjects, trainsubjects)
        
        #Clean environment
        rm (testsubjects, trainsubjects)
        
        testactivity <- read.table(file = paste(datadir,"y_test.txt", sep = ""))
        trainactivity <- read.table(file = paste(datadir,"y_train.txt", sep = ""))
        activity <- bind_rows(testactivity, trainactivity)
        #print(paste("Imported", nrow(activity),"activity entries" ))
        
        #Clean environment
        rm(testactivity, trainactivity)
        
        testdata <- read.table(file = paste(datadir,"X_test.txt", sep = ""))
        traindata <- read.table(file = paste(datadir,"X_train.txt", sep = ""))
        data <- bind_rows(testdata,traindata)
        #print("Imported data entries")
        
        #Clean environment
        rm(testdata, traindata)
        
        #Reading in data column names, setting the blank entry to NA and then clearing it 
        datacolnames <- read.delim (file = paste(datadir,"features.txt", sep = ""), header = FALSE, colClasses = c("NULL", "character"), sep = "")
        datacolnames[datacolnames == ""]<- NA
        datacolnames <- datacolnames[complete.cases(datacolnames),] # This clears the empty NA value and converts to character vector to be used to name the data columns later


# Objective 1 - Merging the complete data set


        merged_data <- bind_cols(subjects, activity, data)
        print("Objective 1 Completed - Merged complete data set")
        
        # Clean environment
        rm(subjects, activity, data)

# Objective 2 - Filtering dataset so we only have the mean and sd for each meauserment
        #Identify data columns with mean and sd in the name
        filtereddatacols <- as.numeric(grep("mean|Mean|std", datacolnames))
        
        # Our first 2 columns are for the subject and activity and we do not want to filter them out 
        filteredcols <- filtereddatacols + 2
        filteredcols <- as.numeric(c("1", "2", filteredcols))
        
        
        #creating the filtered data set here
        filtered_data <- merged_data[,c(filteredcols)]
        print ("Objective 2 Completed - Filtered data set created")
        
        #Clean envirnoment
        rm(merged_data)

# Objective 3 - Add descriptive activity names by replacing the values in the second "Activity" column
        filtered_data[[2]] <- recode(filtered_data[[2]], "1" = "Walking", "2" = "Walking Upstairs", "3" = "Walking Downstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying")
        print ("Objective 3 Completed - Descriptive activity names assigned to the filtered data set")

# Objective 4 - Name the variables
        # Get the names for the filtered columns using the logical filtereddatacols value created earlier 
        filtereddatacolnames <- datacolnames[filtereddatacols]
        
        #Add back in the Subject and Activity Columns
        variablenames <- c("Subject", "Activity", filtereddatacolnames)
        
        #Set the column name
        colnames(filtered_data) <- variablenames 
        
        # Update the data column names with more descriptive values
        colnames(filtered_data)<- gsub("^t", "Time ", names(filtered_data))
        colnames(filtered_data)<- gsub("\\(t", " Time ", names(filtered_data))
        colnames(filtered_data)<- gsub("^f", "Frequency ", names(filtered_data))
        colnames(filtered_data)<- gsub("-std\\()"," Standard Deviation",names(filtered_data)) 
        colnames(filtered_data)<- gsub("-mean\\()"," Mean",names(filtered_data))
        colnames(filtered_data)<- gsub("Acc", " Acceleration", names(filtered_data))
        colnames(filtered_data)<- gsub("Gyro", " Gyroscope", names(filtered_data))
        colnames(filtered_data)<- gsub("Mag", " Magnitude", names(filtered_data))
        colnames(filtered_data)<- gsub("Jerk", " Jerk", names(filtered_data))
        colnames(filtered_data)<- gsub("\\(X", " along the X axis", names(filtered_data))
        colnames(filtered_data)<- gsub("\\(Y", " along the Y axis", names(filtered_data))
        colnames(filtered_data)<- gsub("\\(Z", " along the Z axis", names(filtered_data))
        colnames(filtered_data)<- gsub("\\-X", " along the X axis", names(filtered_data))
        colnames(filtered_data)<- gsub("\\-Y", " along the Y axis", names(filtered_data))
        colnames(filtered_data)<- gsub("\\-Z", " along the Z axis", names(filtered_data))
        colnames(filtered_data)<- gsub("\\-meanFreq\\()", " mean Frequency", names(filtered_data))
        colnames(filtered_data)<- gsub("JerkMean\\)", " Jerk Mean", names(filtered_data))
        colnames(filtered_data)<- gsub("gravityMean\\)", " Gravity Mean", names(filtered_data))
        colnames(filtered_data)<- gsub("gravity\\)", " Gravity", names(filtered_data))
        
        print ("Objective 4 Completed - Descriptive variable Names added to the filtered data set")
        
        #Clean environment
        rm(datacolnames, filteredcols, filtereddatacols, filtereddatacolnames, variablenames)

# Objective 5 - Tidy data set with average for each subject and activity

        tidydataset <- 
                filtered_data %>%
                group_by (Subject, Activity) %>%
                summarize_all(funs(mean))
        
        # Write output file
        write.table(tidydataset, file="tidydataset.txt", row.names = FALSE)

print ("Objective 5 Completed - Please view tidydataset.txt for the results")





  
  

