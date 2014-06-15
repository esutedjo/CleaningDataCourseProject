CleaningDataCourseProject
=========================

Course project in Getting and Cleaning Data

Repo Content:
1. README.MD - this document
2. run_analysis.R - Script to generate tidy data sets
3. TidyData1.txt - Data set for task 1-4 of the course project
4. TidyData2.txt - Data set for task 5 of the course project
5. codebook.MD - description of the data sets


script name: run_analysis.R

requires libraries:
- utils
- reshape2

script content:
1. Downloading data file in ZIP format to local work directory
   output: data.zip
2. Unziping the data file
3. Reading the test and train data sets into dataframes
   output: subject_test, X_test, y_test,
           subject_train, X_train, y_train
           features, activity_labels
4. Data sets for within both test and train are combined
   (subject, activity, measurements)
   output: test.data and train.data
5. Both test and train data sets are combined
   output: all.data
6. Column headers are applied to combined data set
   ouput: all.data having column header
7. Selecting column index for column headers containing
   mean() and std() in the header text. First two columns  
   Subject and Activity are added.
   output: column.index
8. Extracted data set with measurements only on mean and 
   standard deviation
   output: extracted.data
9. Replacing activity code with descriptive activity from
   activity_labels
   output: extracted.data
10.Write results to TidyData1.txt
11.Melt and decast data on the measures. ID are Subject and 
   Activity. Calculate mean of all measures.
   output: mean.data
12.Write results to TidyData2.txt


