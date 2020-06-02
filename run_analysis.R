## Code for the Course Project
# load library.
library(dplyr)

# Zip file of the data
files <- "getdata_projectfiles_UCI HAR Dataset.zip"

## For file download...
# Checking if archieve already exists.
if (!file.exists(files)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, files, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
    unzip(files) 
}

# Loading the first two files...
feat <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
actvs <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
# Loading the subject files...
subject.ta <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject.te <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
# Loading the X and y, test and train, related data...
X.te <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feat$functions)
y.te <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
X.ta <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feat$functions)
y.ta <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## 1. Merging the training and test set...
X <- rbind(X.ta, X.te)
Y <- rbind(y.ta, y.te)

# Merging the subject files
sujeto <- rbind(subject.ta, subject.te)
MergeResult <- cbind(sujeto, Y, X)

## 2. Taking the mean and standard deviation for the values...
CompData <- MergeResult %>% select(subject, code, contains("mean"), contains("std"))

## 3. Naming the activities in the data set...
CompData$code <- actvs[CompData$code, 2]

## 4. Labeling the names...
names(CompData)[2] = "activity"
names(CompData)<-gsub("Acc", "Accelerometer", names(CompData))
names(CompData)<-gsub("Gyro", "Gyroscope", names(CompData))
names(CompData)<-gsub("BodyBody", "Body", names(CompData))
names(CompData)<-gsub("Mag", "Magnitude", names(CompData))
names(CompData)<-gsub("^t", "Time", names(CompData))
names(CompData)<-gsub("^f", "Frequency", names(CompData))
names(CompData)<-gsub("tBody", "TimeBody", names(CompData))
names(CompData)<-gsub("-mean()", "Mean", names(CompData), ignore.case = TRUE)
names(CompData)<-gsub("-std()", "STD", names(CompData), ignore.case = TRUE)
names(CompData)<-gsub("-freq()", "Frequency", names(CompData), ignore.case = TRUE)
names(CompData)<-gsub("angle", "Angle", names(CompData))
names(CompData)<-gsub("gravity", "Gravity", names(CompData))

## 5. Final Data set... 
FinalData <- CompData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
