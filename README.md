# 2ndminiproject
README FOR PROBLEM 1


STEP 1 - Merges the training and the test sets to create one data set.

Code section: 5-17 
- This overall section assigns all data frames required to proceed and then followed by merging training and test sets.
- Read test and train data by accessing the x,y, subject files in "/specdata/UCI HAR Dataset"
- x.test, y.test, subject.test variables contain data from the test folder
- x.train, y.train, subject.train variables contain data from the train folder
- next features and activities are also accessed and saved into 'features' and 'activities' variable. 
- function used for reading data is "read.table"

Code section: 20-23

- rbind is used to bind all x data, y data, and subject data
STEP 2 - Extracts only the measurements on the mean and standard deviation for each measurement.


Code section: 26
- bind all columns using 'cbind' and store merged training and test sets in "train_test.merged" 


STEP 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

- Take the merged data sets from STEP 1 and extract using the 'select()' function from the dplyr library to subset columns using their names and types. Use select to extract mean and standard deviation for each measurement

STEP 3 

- Extract the activity names from the second column of the activities data set and apply descriptive activity names to the data set 'Mean_Std_Data'

STEP 4

Access the names from the 'Mean_Std_Data' using the names() function. 

The gsub() function finds every word matching the parameter and replaces that with our input word or values.

Using the gsub() function replace the labels in the existing data set with descriptive names. 

STEP 5 

Create the final data set. 

These are the function definitions for the transformations  to achieve the final tidy data set

group_by() -Group by one or more variables
summarise_all() - Summarise multiple columns
list() - collect objects to be coerced
mean - generic function for the (trimmed) arithmetic mean.
