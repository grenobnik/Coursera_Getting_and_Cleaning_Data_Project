# Getting and Cleaning Data Course Project
# 2015-07-24
# Kirill Vankov

# Data sourse from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# assume the archive file has been extracted into the directory where this script is located,
# therefore, the path to the training data is UCI HAR Dataset/train/


### 1. Merges the training and the test sets to create one data set.

# load the train data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_activity_codes <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

# load the test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")
test_activity_codes <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# combine both test and train data into a single data frame
data <- rbind(train, test)
activities <- rbind(train_activity_codes, test_activity_codes)
subjects <- rbind(train_subject, test_subject)

# free the memory
rm(test, train)
rm(test_activity_codes, train_activity_codes)
rm(train_subject, test_subject)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# read the measurements names
features <- read.table("UCI HAR Dataset/features.txt", colClasses = c("integer", "character"))[,2]

# find column indexes with mean and standard deviation measurements
idx <- grep("mean\\(\\)|std\\(\\)", features)

# keep only measurements for mean and standard deviation
data <- data[, idx]
features <- features[idx]

# free the memory
rm(idx)


### 3. Uses descriptive activity names to name the activities in the data set

# load the activity code-description
activityDescription <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = c("integer", "character"))[,2]
# convert activityDescription into human friendly strings
activityDescription = gsub("_", " ", tolower(activityDescription))

# convert the activity codes into factors with descriptive labels
activities[,1] <- factor(activities[,1], labels = activityDescription)

# free the memory
rm(activityDescription)


### 4. Appropriately labels the data set with descriptive variable names.

# combine into one data frame the subject column, the activity, the extracted measurements
data <- cbind(subjects, activities, data)

# name the columns 
names(data) <- c("subject", "activity", features)

# write the merged data into a text file as required
write.table(data, 'merged.txt', row.names = FALSE)

# free the memory
rm(activities, subjects, features)


### 5. From the data set in step 4, creates a second, independent tidy data set
###    with the average of each variable for each activity and each subject.

# use aggregate function to group data by activity and subject and compute mean summaries for the rest of the columns
averages <- aggregate(x = data[,-(1:2)], by = list(activity = data$activity, subject = data$subject), FUN = mean)

# write the resulting means into a text file as required
write.table(averages, 'averages.txt', row.names = FALSE)
