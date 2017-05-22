### Getting and Cleaning Data Assignment.
### Date:- 21 May 2017

#setwd("C:/VK_Enterprise/DataScienceSpecialization")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet 
unzip(zipfile="./data/Dataset.zip",exdir="./data")


# Reading trainings tables:
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables:
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')


colnames(xtrain) <- features[,2] 
colnames(ytrain) <-"activityId"
colnames(subjecttrain) <- "subjectId"

colnames(xtest) <- features[,2] 
colnames(ytest) <- "activityId"
colnames(subjecttest) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

## Merging Train & Test DataSet
mrgingTrain <- cbind(ytrain, subjecttrain, xtrain)

mrgingTest <- cbind(ytest, subjecttest, xtest)

mergeDataSet <- rbind(mrgingTrain, mrgingTest)


## Reading Column Names
colNames <- colnames(mergeDataSet)

## Creating Vector for ID, Mean & StdDeviation
vMeanAndStdD <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | 
                   grepl("std.." , colNames))

## Creating subset from Consolidated DataSet
subSetForMeanAndStd <- mergeDataSet[ , vMeanAndStdD == TRUE]

## Assign descriptive activity names to name the activities in the data set:
subsetWithActivityNames <- merge(subSetForMeanAndStd, activityLabels, by='activityId', all.x=TRUE)

##Creating TidySet
tidySet <- aggregate(. ~subjectId + activityId, subsetWithActivityNames, mean)

tidySet <- tidySet[order(tidySet$subjectId, tidySet$activityId),]

## Writting TidySet data into text file.
write.table(tidySet, "TidySet.txt", row.name=FALSE)

