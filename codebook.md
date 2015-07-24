# Codebook

## Short Project Description

This is a project for Coursera "Getting and Cleaning Data" class. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The data should be prepared by using an R script called [run_analysis.R](run_analysis.R) that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

See [README.md](README.md) file for more details.

## Study design and data processing

The data represent measurements collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). In particular, the ``README.txt`` file describes the study design as follows:
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Creating the tidy datafile

The tidy data are created using [run_analysis.R](run_analysis.R) script, see [README](README.md) for details. Briefly, the provided data for training and for test are merged together. Then, only requested measurements are retained. Note, the measurements descriptions are provided in original data folder in file ``UCI HAR Dataset/features_info.txt``. We retain only the features, that are related to _mean values_ and _standard deviation_, i.e. containing the substrings _mean()_ or _std()_. 

The resulting tidy data frame contains 68 variables including:
* first column "activity" in human readable form
+ strings "walking", "walking upstairs", "walking downstairs", "sitting", "standing", "laying";
* second column "subject" with anonymous subject id number,
+ integer index from 1 to 30;
* following 66 retained features which were averaged for each activity and each subject
+ numeric values.

There are 180 resulting observations for each unique pair of (activity, subject).
