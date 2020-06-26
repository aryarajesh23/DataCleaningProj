library(dplyr)
filename <- "Courseraproj.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("","functions"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject <- rbind(subject_train, subject_test)
mergeddata <- cbind(subject, Y, X)
tempdata <- mergeddata %>% select(subject, code, contains("mean"), contains("std"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
tempdata$code <- activities[tempdata$code, 2]
names(tempdata)[2] = "activity"
names(tempdata)<-gsub("^t", "time", names(tempdata))
names(tempdata)<-gsub("^f", "frequency", names(tempdata))
names(tempdata)<-gsub("-mean()", "mean", names(tempdata), ignore.case = TRUE)
names(tempdata)<-gsub("-std()", "std", names(tempdata), ignore.case = TRUE)
names(tempdata)<-gsub("-freq()", "frequency", names(tempdata), ignore.case = TRUE)
outputdata <- tempdata %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean=mean))
write.table(outputdata, "outputdata.txt", row.name=FALSE)