#Will need reshape2
library(reshape2)


#load data

column.names <- read.table("UCI HAR Dataset/features.txt", colClasses="character")
column.names <- column.names[,2]

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train<- read.table("UCI HAR Dataset/train/X_train.txt")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train<- read.table("UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train<- read.table("UCI HAR Dataset/train/y_train.txt")

#Merge test and train for X and y

test_merge<- cbind(X_test, y_test, col.names="Activity"))
train_merge <- cbind(X_train, y_train, col.names="Activity"))


#merge with subjects.

test_subject_merge <- cbind(test.data,subject_test, col.names="Subject"))
train_subject_merge <- cbind(train.data, subject_train, col.names="Subject"))


#merging all into one

data.set <- rbind(test_subject_merge,train_subject_merge)



#Load Activity lables

activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
data.set[,"Activity"] = activity.labels[data.set[,"Activity"], 2]



#Only mean and std


choosen.column.numbers <- grep("-mean\\(\\)|-std\\(\\)", column.names)


#extracting data

extracted.data.set <- data.set[,c(562,563, choosen.column.numbers)]


#Create final data

molten <- melt(extracted.data.set, id.vars=c("Activity","Subject"))
tidy.data.set <- dcast(molten, Activity + Subject ~ variable, mean)

write.table(tidy.data.set, "tidy_data_set.txt")