# Create "Project" directory
#if(!file.exists("project")){dir.create("project")}

setwd("./project")

# Download File
#fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL, destfile = "getdata_project_Dataset.zip")

# Unzip Downloaded File
#unzip("getdata_project_Dataset.zip")

# load activity labels from files
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])

# load features data
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# requirement is to extract only the measurements on the mean and standard 
# deviation for each measurement
reqd_features <- grep(".*mean.*|.*std.*", features[,2])
reqd_features.names <- features[reqd_features,2]
reqd_features.names = gsub('-mean', 'Mean', reqd_features.names)
reqd_features.names = gsub('-std', 'Std', reqd_features.names)
reqd_features.names <- gsub('[-()]', '', reqd_features.names)


# Load trainging datasets
trainingData       <- read.table("UCI HAR Dataset/train/X_train.txt")
# sub-set required features
trainingData       <- trainingData[reqd_features]
trainingActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainingSubjects   <- read.table("UCI HAR Dataset/train/subject_train.txt")
training <- cbind(trainingSubjects, trainingActivities, trainingData)

# load test data
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
# sub-set required features
testData <- testData[reqd_features]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, testData)

# merge training and test data
mergedData <- rbind(training, test)

# add labels to merged data
colnames(mergedData) <- c("subject", "activity", reqd_features.names)

# convert to factors
mergedData$activity <- factor(mergedData$activity, levels = activity_labels[,1], 
                              labels = activity_labels[,2])
mergedData$subject <- as.factor(mergedData$subject)

library(reshape2)

mergedData.melted <- melt(mergedData, id = c("subject", "activity"))
mergedData.mean <- dcast(mergedData.melted, subject + activity ~ variable, mean)

write.table(mergedData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)