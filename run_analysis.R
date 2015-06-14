run_analysis <- function() {
    
    ## This script processes a data set from UC Irvine Machine Learning Repository for a Samsung
    ## phone experiment with 30 volunteers performing 6 tasks and looking at the gyro output.
    
    ## load data
    X_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
    X_test  <- read.table("UCI_HAR_Dataset/test/X_test.txt")
    y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")
    y_test  <- read.table("UCI_HAR_Dataset/test/y_test.txt")
    subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
    subject_test  <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
    features  <- read.table("UCI_HAR_Dataset/features.txt")
    ## Assign column labels
    names(subject_train)<-c("Subject")
    names(subject_test)<-c("Subject")
    names(y_test)<-c("Activity")
    names(y_train)<-c("Activity")
    
    ## STEP 1: Merge the training and the test sets to create one data set.
    ## combine columns
    temp1 <- cbind(X_train, subject_train)
    temp2 <- cbind(temp1, y_train)
    temp3 <- cbind(X_test, subject_test)
    temp4 <- cbind(temp3, y_test)
    ## combine rows
    df <- rbind(temp2, temp4)
    ## clear temp variables
    remove("temp1","temp2","temp3","temp4")
    
    ## Step 2: Extract only the measurements on the mean and standard deviation for each measurement. 
    ## I have interpreted this as: extract only those measurements having each a mean AND a std, and therefore
    ## I discard measurements for meanFreq() and also angle() (which includes "Mean" descriptors).
    subfeatures_col<-c(features[grep("mean\\(",features$V2),]$V1,features[grep("std\\(",features$V2),]$V1)  ## column numbers
    subfeatures_name<-features[c(features[grep("mean\\(",features$V2),]$V1,features[grep("std\\(",features$V2),]$V1), ]$V2  ## column names
    subfeatures_name<-as.character(subfeatures_name)
    df2 <- df[,c(subfeatures_col,562,563)]
    
    ## Step 4: create descriptive feature variable names
    subfeatures_name <- sub("X", "_Xaxis", subfeatures_name)
    subfeatures_name <- sub("Y", "_Yaxis", subfeatures_name)
    subfeatures_name <- sub("Z", "_Zaxis", subfeatures_name)
    subfeatures_name <- sub("-mean\\(\\)-", "_Mean", subfeatures_name)
    subfeatures_name <- sub("-mean\\(\\)", "_Mean", subfeatures_name)
    subfeatures_name <- sub("-std\\(\\)-", "_Std", subfeatures_name)
    subfeatures_name <- sub("-std\\(\\)", "_Std", subfeatures_name)
    colnames(df2)[1:66]<-c(subfeatures_name)
    
    ## Step 3: Use descriptive activity names to name the activities in the data set
    df2$Activity <- as.character(df2$Activity)
    df2$Activity <- sub("1","WALKING",df2$Activity)
    df2$Activity <- sub("2","WALKING_UPSTAIRS",df2$Activity)
    df2$Activity <- sub("3","WALKING_DOWNSTAIRS",df2$Activity)
    df2$Activity <- sub("4","SITTING",df2$Activity)
    df2$Activity <- sub("5","STANDING",df2$Activity)
    df2$Activity <- sub("6","LAYING",df2$Activity)
    
    ## Step 5: From the data set in step 4, create a second, independent tidy data set
    ## with the average of each variable for each activity and each subject.
    tidydf <- aggregate(df2[,1:66],by=list(df2$Activity,df2$Subject), FUN=mean)
    colnames(tidydf)[1]="Activity"
    colnames(tidydf)[2]="Subject"
    
    ## Save as text file
    write.table(tidydf,"/Users/gg/gitstuff/GettingAndCleaningDataCourseProject/tidyData.txt", row.name=FALSE)
}