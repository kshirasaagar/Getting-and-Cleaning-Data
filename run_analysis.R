
## Date - 3/22/2015
## Code - Getting And Cleaning Data - Project Assignment

## This code has three parts
## Part I - Reads all test and training datasets along with labels/descriptions
## Part II - Merges the test and training datasets & labels the activity names
## Part III - Summarizes the averages of variables at a subject-activity level

## The final tidy summary dataset is exported out to a .txt file

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## PART I : INPUT ALL DATASETS, ASSIGN VARIABLE NAMES & KEEP ONLY USEFUL COLUMNS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Data from the main directory

setwd('C:\\Users\\kshira\\Documents\\UCI HAR Dataset')
features <- read.table('features.txt')

labels <- read.table('activity_labels.txt')
colnames(labels) <- c("Activity_No","Activity")

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Data from the training directory
setwd('C:\\Users\\kshira\\Documents\\UCI HAR Dataset\\train')

x_train <- read.table('X_train.txt')
colnames(x_train) <- features[,2]

y_train <- read.table('Y_train.txt')
colnames(y_train) <- c("Activity_No")

subject_train <- read.table('subject_train.txt')
colnames(subject_train) <- c("Subject")

x_data <- cbind(x_train,y_train,subject_train)

#Keeping only the activity, subject, mean and std values of the training dataset
keep <- c("Subject","Activity_No",
          grep("mean()",names(x_train),value = TRUE, fixed = TRUE),
          grep("std()",names(x_train),value = TRUE, fixed = TRUE))

train_data <- x_data[keep]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Data from the test directory
setwd('C:\\Users\\kshira\\Documents\\UCI HAR Dataset\\test')

x_test <- read.table('X_test.txt')
colnames(x_test) <- features[,2]

y_test <- read.table('Y_test.txt')
colnames(y_test) <- c("Activity_No")

subject_test <- read.table('subject_test.txt')
colnames(subject_test) <- c("Subject")

x_data <- cbind(x_test,y_test,subject_test)
#Keeping only the activity, subject, mean and std values of the test dataset
keep <- c("Subject","Activity_No",
          grep("mean()",names(x_test),value = TRUE, fixed = TRUE),
          grep("std()",names(x_test),value = TRUE, fixed = TRUE))

test_data <- x_data[keep]


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## PART II : MERGE TEST AND TRAIN DATASETS & LABEL THE ACTIVITIES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Merging the test and train datasets    
data <- rbind(train_data,test_data)

#Labelling the activity names by joining those two tables
data <- merge(data,labels,by = "Activity_No",all = TRUE)

#Removing the Activity_No column for easier summarizing
data <- data[-1]


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## PART III : CREATE A SMALL & TIDY SUMMARY DATASET
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Creating the summary table at subject-activity level using 'aggregate' function
summary <- aggregate(data[2:67],data[c(1,68)],mean)

#Exporting the tidy dataset to a .txt file
write.table(summary,'tidy.txt',row.names = FALSE)
