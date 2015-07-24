# Coursera "Getting and Cleaning Data" Course Project 

## Purpose

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The data should be prepared by using an R script called [run_analysis.R](run_analysis.R) that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## R script ``run_analysis.R``

It is assumed that the data (available from [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)) unzipped conserving the folder structure into the directory where this script is located. Running the command ``Rscript run_analysis.R`` in the terminal produces the tidy data set with the average of each variable for each activity and each subject. The resulted file name is ``averages.txt``, which is submitted to Coursera server.

The script performs the following steps:

1. Merges the training and the test sets to create one data set:
 + load the train data from ``UCI HAR Dataset/train/X_train.txt`` file,
 + load the corresponding activity codes from ``UCI HAR Dataset/train/y_train.txt`` file,
 + load the corresponding subject id from ``UCI HAR Dataset/train/subject_train.txt`` file,
 + load the test data from ``UCI HAR Dataset/test/X_test.txt`` file,
 + load the corresponding activity codes from ``UCI HAR Dataset/test/y_test.txt`` file,
 + load the corresponding subject id from ``UCI HAR Dataset/test/subject_test.txt`` file,
 + combine both test and train data into a single data frame variable ``data``
 + combine both test and train activity codes into a single data frame variable ``activities``
 + combine both test and train subject ids into a single data frame variable ``subjects``
2. Extracts only the measurements on the mean and standard deviation for each measurement:
 + read the measurements names from file ``UCI HAR Dataset/features.txt`` into ``features`` character vector,
 + find column indexes with mean and standard deviation measurements (based on features strings containing ``mean()`` or ``std()`` substrings,
 + keep only measurements for these indexes
3. Uses descriptive activity names to name the activities in the data set:
 + load the activity descriptions from ``UCI HAR Dataset/activity_labels.txt`` file as a character vector,
 + convert activity descriptions into human friendly strings by removing underscore sign and transforming the characters into low case,
 + convert the activity codes into string factors with descriptive labels
4. Appropriately labels the data set with descriptive variable names:
 + combine into one data frame the subject column, the activity, the extracted measurements
 + name the columns as "subject", "activity", and list of features
 + write the merged data into a text file
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 + use aggregate function to group data by activity and subject and compute mean summaries for the rest of the columns
 + write the resulting means into the text file called ``averages.txt`` as required.

As a result, the file ``averages.txt`` contains a tidy data set with 68 columns:

* first column "activity" in human readable form, 
* second column "subject" with anonymous subject id number,
* following 66 measurements which were averaged for each activity and each subject.

There are 180 resulting observations for each unique pair of (activity, subject).
