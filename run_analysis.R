#loading the required packages
library(dplyr)

#Setting the desired working directory
setwd("C:/Users/pc/Desktop/Data Science Getting And Cleaning Data")

filename <- "DataScienceWeek3.zip"

#Downloading the file
if(!file.exists(filename)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl,filename,method = "curl")
}

#saving the downloaded file in a folder
if(!file.exists("UCI HAR Dataset")){
        unzip(filename)
}

#Reading the data from different folders. Simultaneously assigning column names

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merging the sub-components

x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

#Final merge
complete <- cbind(subject,x,y)

#subsetting data on measurements of mean and standard deviation
tidy.data <- complete %>% select(subject,code,contains("mean"),contains("std"))

#Replacing activity codes with activity names
tidy.data$code <- activities[tidy.data$code,2]

#Labeling the data with descriptive variable names
names(tidy.data)[2] <- "activity"
names(tidy.data) <- gsub("Acc", "Accelerometer", names(tidy.data))
names(tidy.data) <- gsub("Gyro", "Gyroscope", names(tidy.data))
names(tidy.data)<-gsub("BodyBody", "Body", names(tidy.data))
names(tidy.data)<-gsub("Mag", "Magnitude", names(tidy.data))
names(tidy.data)<-gsub("^t", "Time", names(tidy.data))
names(tidy.data)<-gsub("^f", "Frequency", names(tidy.data))
names(tidy.data)<-gsub("tBody", "TimeBody", names(tidy.data))
names(tidy.data)<-gsub("-mean()", "Mean", names(tidy.data), ignore.case = TRUE)
names(tidy.data)<-gsub("-std()", "STD", names(tidy.data), ignore.case = TRUE)
names(tidy.data)<-gsub("-freq()", "Frequency", names(tidy.data), ignore.case = TRUE)
names(tidy.data)<-gsub("angle", "Angle", names(tidy.data))
names(tidy.data)<-gsub("gravity", "Gravity", names(tidy.data))

#Forming a new dataset which contains the average of each variable for each activity and each subject
new.tidy.data <- tidy.data %>% 
                group_by(subject,activity) %>%
                summarise_all(funs(mean))

#Writing the new dataset into a file.
write.table(new.tidy.data, "TidyData.txt", row.names = F)
