## dplyr library is required for ultimate summary
library(dplyr)

## Load the test data, activity labels, and subject labels
test_data = read.fwf("UCI HAR Dataset/test/X_test.txt",header = FALSE,widths = rep.int(16,561),buffersize = 100)
test_labels = read.csv("UCI HAR Dataset/test/y_test.txt",header = FALSE,sep = " ")
test_subjects = read.csv("UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep = " ")

## Append activity labels to the 'test' data set
test_data$activity = test_labels[,1]
test_data$subject = test_subjects[,1]

## Load the train data, activity labels, and subject labels
train_data = read.fwf("UCI HAR Dataset/train/X_train.txt",header = FALSE,widths = rep.int(16,561),buffersize = 100)
train_labels = read.csv("UCI HAR Dataset/train/y_train.txt",header = FALSE,sep = " ")
train_subjects = read.csv("UCI HAR Dataset/train/subject_train.txt",header = FALSE,sep = " ")

## Append activity labels to the 'train' data set
train_data$activity = train_labels[,1]
train_data$subject = train_subjects[,1]

## Load the column names from a separate file
column_names = read.csv("UCI HAR Dataset/features.txt",header = FALSE,sep = " ")

## Load the activity names and their associated codes
activity_names = read.csv("UCI HAR Dataset/activity_labels.txt",header = FALSE,sep = " ")

## Concatenate the data sets.  All columns are the same, so a simple 'rbind' is sufficient
all_data = rbind(test_data,train_data)

## Replace activity codes with activity names
all_data$activity=factor(all_data$activity,labels = activity_names$V2)

## Rename all columns
names(all_data) = c(as.character(column_names[,2]),"activity","subject")

## Select only the columns containing means and standard deviations for both time and frequency domain quantities
## The vector contains column numbers for each value, with the 'subject' and 'activity' columns in front
selected_columns = sort(c(grep(pattern = "mean\\(",names(all_data)),grep(pattern = "std",names(all_data))))
selected_columns = c(match("subject",names(all_data)),match("activity",names(all_data)),selected_columns)

## Create the subset
selected_data = all_data[,selected_columns]

##Execute string replacements on column names for human-readability
names(selected_data) = gsub('\\(\\)','',names(selected_data))
names(selected_data) = gsub('-','_',names(selected_data))
names(selected_data) = gsub('BodyAcc','_Body_Acceleration',names(selected_data))
names(selected_data) = gsub('GravityAcc','_Gravitational_Acceleration',names(selected_data))
names(selected_data) = gsub('BodyAccJerk','_Body_Acceleration_Jerk',names(selected_data))
names(selected_data) = gsub('BodyGyro','_Body_Gyro',names(selected_data))
names(selected_data) = gsub('BodyGyroJerk','_Body_Gyro_Jerk',names(selected_data))
names(selected_data) = gsub('BodyAccMag','_Body_Acceleration_Magnitude',names(selected_data))
names(selected_data) = gsub('GravityAccMag','_Gravitational_Acceleration_Magnitude',names(selected_data))
names(selected_data) = gsub('BodyAccJerkMag','_Body_Acceleration_Jerk_Magnitude',names(selected_data))
names(selected_data) = gsub('BodyGyroMag','_Body_Gyro_Magnitude',names(selected_data))
names(selected_data) = gsub('BodyGyroJerkMag','_Body_Gyro_Jerk_Magnitude',names(selected_data))
names(selected_data) = gsub('t_','Time_',names(selected_data))
names(selected_data) = gsub('f_','Frequency_',names(selected_data))

## Find the average of each column using dplyr methods
summary_data = selected_data %>% group_by(subject,activity) %>% summarise_each(funs(mean))

## Write to an output file
write.table(summary_data,file = "getting_cleaning_data_course_project_summary.txt",row.name=FALSE)