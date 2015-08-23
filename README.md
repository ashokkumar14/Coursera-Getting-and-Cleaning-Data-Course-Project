# Coursera-Getting-and-Cleaning-Data-Course-Project
Peer Assessment Project - Getting and Cleaning Data Course Project

The R script, run_analysis.R, does the following:

1. Check working directory and create if it does not exist
2. Download the dataset 
3. Load activity labels and features info
3. Load training and test datasets and subset only required columns - which      reflect mean or standard deviation
4. Load activity and subject data for each dataset, and merge those columns with relevant dataset
5. Merge training and test datasets
6. Convert activity and subject columns into factors
7. Create tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is written to file tidy.txt.
