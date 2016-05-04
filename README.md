## Tidy UCI HAR Dataset

# By Danicat <daniela.petruzalek@gmail.com>

The purpose of this repo is to provide a R script for tidying the data of the UCI's "Human Activity Recognition Using Smartphones Dataset" (for now on referenced as UCI HAR Dataset) version 1.0.

This repo is composed of one R script called "run_analysis.R" that does all the work. Basically it will:

1. Merge the training and the test sets to create one data set (called "ds")
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject (called "ds2")

Note: The script will look for a directory called "UCI HAR Dataset" on the current working directory. If it doesn't exist, it will create it by downloading the RAW dataset and uncompressing it. If it does exist, it will assume that the RAW dataset is extracted in this directory and proceed.

In order to run the script as is, type on the R prompt:

> source("run_analysis.R")

## RAW Dataset

The raw dataset complete description can be found at the link below:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This script downloads the data from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Code Book

For the complete reference of the "UCI HAR Tidy Dataset" please check the CodeBook.md file included in this repository.

## Contact Info

For information and/or comments, feel free to contact me at daniela.petruzalek@gmail.com. I'm also available on Twitter (@danicat83) and LinkedIn (http://br.linkedin.com/petruzalek)

## References

1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
