# Getting and Cleaning Data - Course Project

The run_analysis.R code serves to answer the five questions provided in the Getting and Cleaning Data course project 
assignment - this is done through three parts in the code.

Part I - Reading the datasets from the UCIHAR directory on local
 - First the features list is read into an object called 'features' - this shall serve as column names for all datasets
 - The activity labels are then read and stored in a 'labels' datasets for future usage
 - The x_train(actual values), y_train(Activity Codes) and subject_train(Subject Number) are inputted into 3 objects
 - Similar exercise is conducted for the test datasets as well
 - Using a grep function, only column names with exact terms mean() & std() are retained along with subject & activity


Part II - Merging the test and train datasets, and labelling the activities
 - Using rbind both the test and train datasets are successfully merged into one dataset
 - The actual activity labels are also appeneded by merging the 'activity no' from the merged and labels dataset
 - Unnecessary columns like activity_no is removed to make it easier for summarization


Part III - Creating a small and tidy summary dataset
 - Through the 'aggregate' function, the average values for all the 66 variables are obtained at a subject-activity level
 - The final summarized tidy dataset is written to a 'tidy.txt' file and exported to local
