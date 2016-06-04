## Coursera Getting and Cleaning Data Course Project
## Ricardo Pinto
## 2016-06-04

# runAnalysis.r - this script will perform the following steps:
# 1. Download the UCI HAR Dataset
# 2. Merge the training and the test sets to create one data set.
# 3. Extract only the measurements on the mean and standard deviation for each measurement.
# 4. Use descriptive activity names to name the activities in the data set.
# 5. Appropriately label the data set with descriptive activity names.
# 6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile = "UCI_HAR_Dataset.zip"
# Downloads the UCI HAR Dataset to the working directory
download.file(dataUrl, destfile = zipFile, method = "curl")
# Unzips the UCI HAR Dataset
unzip(zipFile)

# Load features names and selects measurements on the mean and standard deviation
features <- read.table("UCI HAR Dataset/features.txt")
mean_std_features_index <- grep("-mean()|-std()",features[, 2])
mean_std_features_names <- grep("-mean()|-std()",features[, 2], value = TRUE)

# Label the data set with descriptive variable names
mean_std_features_names <- gsub("^t", "time", mean_std_features_names)
mean_std_features_names <- gsub("^f", "frequency", mean_std_features_names)
mean_std_features_names <- gsub("mean", "Mean", mean_std_features_names)
mean_std_features_names <- gsub("std", "Std", mean_std_features_names)
mean_std_features_names <- gsub("\\(\\)", "", mean_std_features_names)
mean_std_features_names <- gsub("-", "", mean_std_features_names)

# Load activity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Load subject, actitities and test data set
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")[mean_std_features_index]
# Merge test data set and rename columns
test <- cbind(test_subject, test_activities, test)
names(test) <- c("subject", "activity", mean_std_features_names)

# Load subject, activities and training data set
training_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
training_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
training <- read.table("UCI HAR Dataset/train/X_train.txt")[mean_std_features_index]
# Merge training data set and rename columns
training <- cbind(training_subject, training_activities, training)
names(training) <- c("subject", "activity", mean_std_features_names)

# Merge the test and the training sets to create one data set
merge <- rbind(test, training)

# Descriptive activity names to name the activities in the data set
merge$activity <- factor(merge$activity, levels = as.character(activities[, 1]), labels = as.character(activities[, 2]))
merge$subject <- factor(merge$subject)

# Create independent tidy data set with the average of each variable for each activity and each subject
tidyDataColumns <- !(names(merge) %in% c("activity", "subject"))
tidyData <- aggregate(merge[, tidyDataColumns], by=list(subject=merge$subject, activity=merge$activity), FUN=mean)