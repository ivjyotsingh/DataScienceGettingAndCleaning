The run_analysis.R script follows the 5 steps as mentioned in the Getting and Cleaning Data's Week 4 project assignment.

The aim of the assignment is achieved through the steps below.
        
1. The dataset is downloaded and extracted under the folder called UCI HAR Dataset.

2. Each data in the folder is assigned a variable name.

        - features <- features.txt : 561 rows, 2 columns.The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
        - activities <- activity_labels.txt : 6 rows, 2 columns. List of activities performed when the corresponding measurements were taken and its codes (labels).
        - subject_test <- test/subject_test.txt : 2947 rows, 1 column. Contains test data of 9/30 volunteer test subjects being observed.
        - x_test <- test/X_test.txt : 2947 rows, 561 columns. Contains recorded features test data.
        - y_test <- test/y_test.txt : 2947 rows, 1 columns. Contains test data of activities’code labels.
        - subject_train <- test/subject_train.txt : 7352 rows, 1 column. Contains train data of 21/30 volunteer subjects being observed.
        - x_train <- test/X_train.txt : 7352 rows, 561 columns. Contains recorded features train data.
        - y_train <- test/y_train.txt : 7352 rows, 1 columns. Contains train data of activities’code labels.

3. Merges the training and the test sets to create one data set
        
        - x (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
        - y (10299 rows, 1 column) is created by merging y_train and y_test using   rbind() function
        - subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
        - complete (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

4. Extracting only the measurements on mean and standard deviation for each measurement

        tidy.data (10299 rows, 88 columns) is created by subsetting complete, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement.

5. Uses descriptive activity names to name the activities in the data set
        
        Numbers in the code column of the tidy.data replaced with the corresponding activity taken from second column of the activities variable.

6. Appropriately labels the data set with descriptive variable names code column in tidy.data renamed into activities
        
        - All Acc in column’s name replaced by Accelerometer
        - All Gyro in column’s name replaced by Gyroscope
        - All BodyBody in column’s name replaced by Body
        - All Mag in column’s name replaced by Magnitude
        - All start with character f in column’s name replaced by Frequency
        - All start with character t in column’s name replaced by Time

7. Creating a second, independent tidy data set with the average of each variable for each activity and each subject

        new.tidy.data (180 rows, 88 columns) is created by sumarizing tidy.data taking the means of each variable for each activity and each subject, after grouped by subject and activity.

8. Export FinalData into TidyData.txt file.