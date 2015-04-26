## Code Book

################################################################################

## A note on units

All acceleration values in the tables are in units of gravitational
acceleration, "g".  The units for the 'gyro' variables indicating
gyration are in radians / second.  The units for the jerk variables
are not given, but are presumably "g / second".



################################################################################

## Variables Used

## Storage data frames for the "test" data set values, activity codes,
## and subject numbers, respectively
test_data, test_labels, test_subjects

## Storage data frames for the "train" data set values, activity codes,
## and subject numbers, respectively
train_data, train_labels, train_subjects

## Table of activity names for the various activity codes
activity_names

## Names of the columns for both the "test" and "train" data sets
column_names

## Full data set
all_data

## Vector of columns desired for the reduced data set
selected_columns

## Table of averaged values
summary_data

################################################################################

Several transformations are performed on the raw data

1) Subject codes and activity codes are appended to the 
   acceleration/gyration data set

2) Activity codes are replaced with activity labels from the file
   "UCI HAR Dataset/activity_labels.txt"

3) Column names are taken from the file "UCI HAR Dataset/features.txt"
   and modified for easier human readability.  Specifically,
   parentheses are removed, dashes are replaced with underscores, time
   versus frequency domain variables are made more explicit, and the
   remainder of the names are expanded.  For instance, 

   tBodyAcc-mean()-X -> Time_Body_Acceleration_mean_X

4) Only the mean and standard deviation values for each type of
   measurement are extracted

5) A summary table is provided with averages of each value in the
   table split up by subject number and activity
