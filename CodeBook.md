# CodeBook

## The Raw Dataset

The raw dataset [1] includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are also included but they were not used to generate the tidy data set, so are listed here just for reference.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## The Tidy Dataset

The tidy data set was obtained by executing the following tasks:

### 1. Merge the training and test sets to create one data set

Merge 'X_test.txt' with 'X_train.txt' to produce a single "measure" data frame
Merge 'y_test.txt' with 'y_train.txt' to produce a single "activity" data frame
Merge 'subject_test.txt' with 'subject_test.txt' to produce a single "subject" data frame

Merge all resulting data frames to combine columns activity (from y_*.txt) and subject (from subject_*.txt) with the measures (from X_*.txt) forming a complete data set will all desired columns.

Please note that in the supplied R script, the final merge of the three data frames cited above to produce the completed data set was done in the Task 4, in order to facilitate the processing of the next tasks.

### 2. Extract only the measurements on the mean and standard deviation for each measurement.

The 'features.txt' file contains all the measurements' names and hence it was used to select only the required columns from the "measure" data frame. The result was stored in the "measure.cols" data frame

### 3. Use descriptive activity names to name the activities in the data set

The 'activity_label.txt' file contains the descriptive activity names. It was used to convert the "activity" data frame into the "activity.f" factor variable that contains all the corresponding activity names to the observations.

### 4. Appropriately label the data set with descriptive variable names.

The names for the "measure.cols" data frame were extracted from 'features.txt' the same way it was used to extract the column ids. It was then post-processed to remove special characters like "(),-" because this type of character makes the R sintax less readable/human friendly.

The complete data set was built by merging the "activity.f" factor with the "subject" data frame and the "measure.cols" data frame using dplyr's bind_cols. Basically this adds the 'activity' and 'subject' columns to the selected measures.

So the final step in preparing the tidy dataset was to rename the columns 1 and 2 to reflect the names "activity" and "subject" respectively. The final data set was stored in the table data frame (tbl_df) called 'ds'.

### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

This data set was called "ds2" and was produced basically by pipelining the following dplyr functions: mutate, group_by and summarize_each.

mutate, while not actually needed, was used to explicitly cast the "subject" column from ds to a factor.

group_by was used to group the data set by activity and subject.

summarize_each was used to calculate the mean for all measures in the data set.

The final result is stored in "ds2".

## Contact Info

For information and/or comments, feel free to contact me at daniela.petruzalek@gmail.com. I'm also available on Twitter ([@danicat83](https://twitter.com/danicat83)) and LinkedIn (http://br.linkedin.com/in/petruzalek)

## References

1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
