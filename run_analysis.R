## Getting and Cleaning Data - Course Project
#
# By Daniela Petruzalek <daniela.petruzalek@gmail.com>
#
# The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
# 
# Dataset Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# This R script (run_analysis.R) does the following. 
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

# Save current working directory
old.path <- getwd()

# The code below will download and extract the data if necessary.
if( !dir.exists("UCI HAR Dataset") ) {
        if( !file.exists("UCI HAR Dataset.zip") ) {
                download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "UCI HAR Dataset.zip")
        }
        unzip("UCI HAR Dataset.zip") # automatically creates the "UCI HAR Dataset
}

# You must be on the directory you've unziped the file, or alter the line below accordingly
setwd("UCI HAR Dataset")

# The dataset includes the following files:
# =========================================
#       
# - 'README.txt'
# - 'features_info.txt': Shows information about the variables used on the feature vector.
# - 'features.txt': List of all features.
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'train/X_train.txt': Training set.
# - 'train/y_train.txt': Training labels.
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.
#
# The following files are available for the train and test data. Their descriptions are equivalent. 
#
# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
# - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
# - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
# - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

# Load files to memory, variable names kept same as file names for consistency
activity_labels <- read.table("activity_labels.txt")
features        <- read.table("features.txt")

X_train <- read.table("train/X_train.txt") # Training set.
y_train <- read.table("train/y_train.txt") # Training labels.

X_test  <- read.table("test/X_test.txt") # Test set.
y_test  <- read.table("test/y_test.txt") # Test labels.

subject_train <- read.table(file.path("train","subject_train.txt"))
subject_test  <- read.table(file.path("test","subject_test.txt"))

## The files below were not needed for this project
#total_acc_x_train <- read.table(file.path("train","Inertial Signals","total_acc_x_train.txt"))
#body_acc_x_train  <- read.table(file.path("train","Inertial Signals","body_acc_x_train.txt"))
#body_gyro_x_train <- read.table(file.path("train","Inertial Signals","body_gyro_x_train.txt"))
#total_acc_x_test <- read.table(file.path("test","Inertial Signals","total_acc_x_test.txt"))
#body_acc_x_test  <- read.table(file.path("test","Inertial Signals","body_acc_x_test.txt"))
#body_gyro_x_test <- read.table(file.path("test","Inertial Signals","body_gyro_x_test.txt"))

# Task 1: Merge the training and the test sets to create one data set.
#
# Combine the training and test rows of X (set), y (labels) and subject (note: 'test' comes first)
measures <- bind_rows(mget(ls(pattern = "^X_")))
activity <- bind_rows(mget(ls(pattern = "^y_")))
subject  <- bind_rows(mget(ls(pattern = "^subject_")))

# Note: I'll create the complete data set after finishing naming the columns in Task 4

# Task 2: Extract only the measurements on the mean and standard deviation for each measurement. 
#
# According to the data set's README.txt, mean and standard deviation measurements are post-fixed with mean() and std(), 
# respectively. I will use the 'features' vector to select the names we want and use their positions (same as features$V1) 
# to index 'X'

# features$V2 lists the columns in order, so it's just a matter of selecting the columns corresponding to the features's rows
cols          <- grep("(mean\\(\\)|std\\(\\))", features$V2)
measures.cols <- measures[, cols]

# I'll also use the same strategy to name those columns (Task 4)
measures.names <- grep("(mean\\(\\)|std\\(\\))", features$V2, value = TRUE)

# R doesn't like special characters very much, so I'll remove then completely to make things a bit easier to work
names(measures.cols) <- gsub("[(),-]", "", measures.names)

# Task 3: Uses descriptive activity names to name the activities in the data set
#
# Now we neet to convert the activities observed in y to their names.
#
# This is actually quite simple: activity_labels has the labels for all possible activities, so I just need to index 
# activity_labels$V2 by activity$V1.

activities.f <- activity_labels$V2[activity$V1] # R automatically casts to factor

# I'll combine now the activity labels with the subjects and measurements for the complete data set:
ds <- bind_cols(as.data.frame(activities.f), subject, measures.cols)

# Task 4. Appropriately labels the data set with descriptive variable names. 
#
# Most of this work was already done, but I still need to rename the activity and subject columns
ds <- rename(ds, activity = activities.f, subject = V1) %>% mutate(subject = as.factor(subject))

# Task 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
# each activity and each subject.

ds2 <- mutate(ds, subject = as.factor(subject)) %>% 
        group_by(activity, subject) %>% 
        summarize_each(funs(mean)) %>% 
        ungroup

# Restore original working dir
setwd(old.path)