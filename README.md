## README

All relevant routine are included in the 'run_analysis.R' script,
which assumed the accelerometer data is included in a folder called
"UCI HAR Dataset" within the working directory.

The script first loads both the 'test' and 'train' data sets, then
appends activity code labels and subject number labels as additional
columns.  The two data sets are concatenated through a simple 'rbind'
method before any other operations are executed.

Once concatenated, several transformations are applied to the data, as
described in the code book file.  Finally, a summary table of averages
for the relevant sub-set of columns is output to the file 

"getting_cleaning_data_course_project_summary.txt" 