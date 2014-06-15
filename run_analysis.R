
## Requires utils package
require("R.utils")

## Loading reshape2 library
library(reshape2)

## Sets environment variable R_WIN_INTERNET2 and set Internet2, so that download.file works in Windows
Sys.setenv(R_WIN_INTERNET2 = TRUE)
setInternet2(TRUE)

## Sets SourceURL with the link of the data source and downloads to work directory with file name data.zip
SourceURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(SourceURL, destfile="data.zip")

## Unzipping zip file
unzip("data.zip", overwrite = TRUE)

## Reading data fDatailes
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Combining test data
test.data <- cbind(subject_test, y_test, X_test)

## Combining train data
train.data <- cbind(subject_train, y_train, X_train)

## Combining test and train data into one data set *task1*
all.data <- rbind(test.data, train.data)

## Apply column headers to data set *task 4*
feature.names <- as.character(features[,2])
names(all.data) <- c("Subject", "Activity", feature.names)

## Find index for columns containing mean() or std()
index.mean <- grepl("mean()", names(all.data), fixed=TRUE)
index.std <- grepl("std()", names(all.data), fixed=TRUE)
column.number <- 1:563
column.index <- c(1,2,sort(c(column.number[index.mean], column.number[index.std])))

## Extracted data set with measurements only on mean and standard deviation *task 2*
extracted.data <- all.data[column.index]

## Use decriptive activity names in Activity column *task3*
## Take the column and replace numbers with the corresponding activity label
activity.column <- extracted.data[,2]
new.column <- NULL
for (i in activity.column) {
	new.column <- append(new.column, as.character(activity_labels[match(i,activity_labels[,1]),2]))
}
extracted.data[,2] <- new.column

## Writing first tidy data set to file
write.table(extracted.data, file="TidyData1.txt", sep =";", col.names=TRUE,row.names=FALSE)

## Create second tidy data set with the average of each variable for each activity
## and each subject *task 5*
measure.names <- names(extracted.data)[3:68]
DataMelt <- melt(extracted.data, id.vars=c("Subject", "Activity"), measure.vars=measure.names)
mean.data <- dcast(DataMelt,Subject + Activity ~ variable, mean)

## Writing second tidy data set to file
write.table(mean.data, file="TidyData2.txt", sep =";", col.names=TRUE,row.names=FALSE)

