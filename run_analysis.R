
library(dplyr)

#====================================================================================
# STEP 1. Merges the training and the test sets to create one data set.
#====================================================================================
x.test <- read.table("specdata/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y.test <- read.table("specdata/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject.test <- read.table("specdata/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x.train <- read.table("specdata/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y.train <- read.table("specdata/UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject.train <- read.table("specdata/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")


features <- read.table("specdata/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("specdata/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))


#Bind the rows for x,y,subject respectively 
X <- rbind(x.train, x.test)
Y <- rbind(y.train, y.test)
Subject <- rbind(subject.train, subject.test)

#Column bind data frames to create one data set consisting of data from subject, y, and x
train_test.merged <- cbind(Subject, Y, X)

#=========================================================================================================
# Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
#=========================================================================================================


#contains function 
Mean_Std_Data <- train_test.merged %>% select(subject, code, contains("mean"), contains("std"))

#=========================================================================================================
#Step 3: Uses descriptive activity names to name the activities in the data set.
#=========================================================================================================

Mean_Std_Data$code <- activities[Mean_Std_Data$code, 2]

#=========================================================================================================
#Step 4: Appropriately labels the data set with descriptive variable names.
#=========================================================================================================

#The gsub() function finds every word matching the parameter and replaces that with our input word or values.

names(Mean_Std_Data)[2] = "activity"
names(Mean_Std_Data)<-gsub("-mean()", "Mean", names(Mean_Std_Data), ignore.case = TRUE)
names(Mean_Std_Data)<-gsub("-std()", "STD", names(Mean_Std_Data), ignore.case = TRUE)
names(Mean_Std_Data)<-gsub("-freq()", "Freq", names(Mean_Std_Data), ignore.case = TRUE)

names(Mean_Std_Data)<-gsub("Acc", "-Accelerometer-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("Gyro", "-Gyroscope-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("BodyBody", "-Body-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("Mag", "-Magnitude-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("^t", "-Time-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("^f", "-Frequency-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("tBody", "-TimeBody-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("angle", "-Angle-", names(Mean_Std_Data))
names(Mean_Std_Data)<-gsub("gravity", "-Gravity-", names(Mean_Std_Data))


#=========================================================================================================
#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#=========================================================================================================

TidyData <- Mean_Std_Data %>%group_by(subject, activity) %>%summarise_all(list(mean))

#------------------------------------
#Display Output
#------------------------------------

TidyData


