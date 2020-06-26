run_analysis.R prepares the data as described in the 5 steps required in the course project’s definition.

Download the dataset: Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign each data to variables:
	Data from features.txt to variable features
	Data from X_test.txt to variable x_test
	Data from y_test.txt to variable y_test
	Data from X_train.txt to variable x_train
	Data from y_train.txt to variable y_train
	Data from activity_labels.txt to variable activities
	Data from subject_test.txt to variable subject_test
	Data from subject_train.txt to variable subject_train

Merge the training and the test sets to create one:
	Using rbind function X is created by merging x_train and x_test
	Using rbind function Y is created by merging y_train and y_test
	Using rbind function subject is created by merging subject_train and subject_test
	Using cbind function mergeddata is created by merging subject, Y and X

Extract mean and standard deviation for each measurement:
	Tempdata is created by subsetting mergeddata, selecting columns subject, code and the measurements on the mean and standard deviation (std) for each measurement

Output data set with the average of each variable for each activity and each subject:
	outputdata is created by sumarizing tempdata taking the means of each variable for each activity and each subject, after groupped by subject and activity. Export outputdata into outputdata.txt file.