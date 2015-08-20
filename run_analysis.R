" You should create one R script called run_analysis.R that does the following. 

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
"

library(dplyr)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels <- rename(activity_labels, activityid = V1, activityname = V2)

feature_names <- read.table("UCI HAR Dataset/features.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

x_test <- setNames(x_test, feature_names[,2])
y_test <- rename(y_test, activityid = V1)
subject_test <- rename(subject_test, subjectid = V1)

full_test <- cbind(subject_test, y_test, x_test)


x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_train <- setNames(x_train, feature_names[,2])
y_train <- rename(y_train, activityid = V1)
subject_train <- rename(subject_train, subjectid = V1)

full_train <- cbind(subject_train, y_train, x_train)
full_set <- rbind(full_train, full_test)
full_set <- merge(full_set, activity_labels, by="activityid")

meta_set <- subset(full_set, TRUE, select=c(subjectid, activityname))
meanstd_set <- subset(full_set, TRUE, grepl("mean()", colnames(full_set)) | grepl("std()", colnames(full_set)))

tidy_set <- cbind(meta_set, meanstd_set)
names(tidy_set) <- tolower(names(tidy_set))
names(tidy_set) <- gsub("-", "", names(tidy_set))

library(reshape)
mtidy_set <- melt(tidy_set, id=c("subjectid", "activityname"))
mtidy_set <- mtidy_set[order(mtidy_set$subjectid, mtidy_set$activityname),]
final_tidy_set <- cast(mtidy_set, subjectid+activityname~variable,mean)

write.table(final_tidy_set, file="tidygalaxydataset.txt", row.names=FALSE)

