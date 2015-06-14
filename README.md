# GettingAndCleaningDataCourseProject
Coursera Data Science Specialization's "Getting and Cleaning Data" Course Project


**The Data Set**
---

Source of raw data: [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

This project summarizes certain results from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, UC Irvine captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

**Files in this Repository**
-------
 - *README.md*: This file.
 - *run_analysis.R*: R-language code used to create output file tidyData.txt (see below). This code assumes the raw data file exists in the working directory.
 - *tidyData.txt*: A tidy data set containing the results of this project. 
 - *code_book.md*: This file describes the variables used in tidyData.txt.

## **How the Script Works** ##

The script in file run_analysis.R performs five main steps:

 1. Merges the training and the test sets to create one data set.

	The script reads in the following data sets: X_train, X_test, y_train, y_test, subject_train, subject_test, and feature.txt. It uses cbind() to combine columns for X_train, y_train, and subject_train, and separately, performs a similar operation for test-related data sets. Then, it uses rbind() to add test- and train-related observations into one data frame.

 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

	I interpreted the above requirement to extract only those measurements having both a mean AND a std, and therefore I discarded measurements for meanFreq() and also angle(), and retained only those containing mean() and std() in their feature names. The script uses grep to single-out these measurements, which results in 66 columns of features/variables (plus one column for Subject and another for Activity). 

 3. Uses descriptive activity names to name the activities in the data set.

	I found it easier to perform step 4 below before this step. The script here uses sub() to replace the numbered activities with character desciptions.

 4. Appropriately labels the data set with descriptive variable names. 

	The script uses sub() and colnames() to make the features column names more readable. It removes dashes and parenthesis, and adds an underscore (e.g. _) to separate distinguishing features.

 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
 
	 The script uses aggregate() to create a new (tidy) table summarizing the mean of each feature column for each activity and subject. Finally, this tidy table of data is saved using write.table() with row.name=FALSE.

