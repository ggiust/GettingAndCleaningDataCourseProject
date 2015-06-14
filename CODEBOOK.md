# GettingAndCleaningDataCourseProject
Coursera Data Science Specialization's "Getting and Cleaning Data" Course Project


**CODE BOOK**
---

## The Raw Data Set ##
Source of raw data: [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The features selected for this data set come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

## Study Design ##

This section describes how the raw data was processed to produce the final tidy data set, tidyData.txt.

The following raw data files were merged into one data frame: features.txt, subject_test.text, subject_train.txt, X_test.txt, y_test.txt, X_train.txt, y_train.txt. 

I interpreted the instructions as requiring me to only retain features having (both) mean *and* std measurements. Thus, only feature columns containing mean() and std() were retained (removing all others). 

The feature columns were renamed with more descriptive labels, and the activity numbers were replaced with meaningful activity names. 

Finally, a tidy data set was created by using the aggregate() function to compute the mean of each feature variable for each activity and each subject. The tidy data set was saved as a text file named tidyData.txt (with row.name=FALSE) using write.table().

## Data Dictionary ##

This section describes all of the variables in the tidyData.txt data set, including units.

**Column 1**

Label: Activity

Class: character

Unique elements:

 - WALKING
 - WALKING_UPSTAIRS
 - WALKING_DOWNSTAIRS
 - SITTING
 - STANDING
 - LAYING

**Column 2**

Label: Subject

Class: integer

Unique elements: integers from 1 to 30, where each integer represents a unique subject (e.g. person).

**Columns 3 to 68**

Label: (see below)

Class: numeric

Each feature column is labeled in the following form:

`<`t|f`><`feature`>_<`Mean|Std`>_<`Xaxis|Yaxis|Zaxis`>`

The first letter is either a **t** to indicate time domain measurement, or an **f** to indicate frequency-domain measurement. Next, the label includes a **feature** text that describes the exact measurement that was made (see below). Next the label includes either **Mean** or **Std** text to indicate an average or standard deviation of the feature. Finally, the label optionally includes an **Xaxis**, **Yaxis**, or **Zaxis** text to indicate the x, y, or z (i.e. height) axis of the measurement.

The **feature** text is one of the following, which describes the measurement that was made during the experiment:

 - BodyAcc
 - GravityAcc
 - BodyAccJerk
 - BodyGyro
 - BodyGyroJerk
 - BodyAccMag
 - GravityAccMag
 - BodyAccJerkMag
 - BodyGyroMag
 - BodyGyroJerkMag

The original raw feature data is normalized and bounded within [-1,1]. 

Each column (3 to 68) represents a feature measurements, where each number is an averaged measurement for a subject performing an activity. There are no units because the data has been normalized (see above).

**Dimensions**

There is one Activity column, one Subject column, and 66 feature columns, for a total of 68 variables (i.e. columns).

There are 6 activities and 30 subjects, for a total of 180 observations (i.e. rows).




