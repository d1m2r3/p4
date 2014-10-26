<<<<<<< HEAD
---
title: "README: Getting and Cleaning Data - Project"
author: "d1m2r3"
date: "Sunday, October 26, 2014"
output: html_document
---

## Organization of run_Analysis.R

### Assumptions
* The script "run_Analysis.R" and input data directory are in the same directory
* Input data   directory is named "UCI HAR Dataset"; this data file is to be loaded MANAUALLY
* It is quite big and takes too long to upload via github 
* Sub-directories and file names in the input directory are unchanged (from course era source)
* Output file (tidy data set) is written to a directory named "Project_2_Results"


### How the script works

Step  1 (All relevant data in one piece)

* Reads the input files of X, Y, and Subject from "test"  and "training" subdirectories
* Convert these into data frames (df's)
* Merge the corresponding df's (e.g., X test and X-train), using 'rbind'
* Combine X, Y, and Subject with cbind

Step  2 (Extracts only the measurements on the mean and standard deviation)

* Read features list file, and extract the list of feature names
* Extract "mean" and "standard deviation" by using grepl() on the list of names
* This yields a binary vector indicating if the feature name has "mean" or "std"
* For most feature names, this test is adequate
* Some feature names on "angular" aspect, containinig "mean" or "std", are ambiguous.
  As I have no domain knowledge, I am retaining it
* Subset the column names of the X-part by this vector

Step 3 (Uses descriptive activity names to name the activities in the data set)

* Read the activities file and extract list of activity code and their descriptive names
* Use it on the Y-column, and replace activity code with its description
* An indirect indexing on the array works here

Step 4 (Appropriately labels the data set with descriptive variable names)

* Subset feature names list (of step 2) with the binary vector (also from step 2)
* Set the column names of the X-part with this subset of feature names

Replace the column names of "subject" and "y" with readable names (e.g., "subjectId", "activityLabel", )

Step 5  (Creates a second, independent tidy data set with the average)

* load the plyr library
* Use the ddply() function as described in the lecture; application is straight-forward
* Use activityLabel and subjectId as the main row indexes
* Use numcolwise(mean) as the summary function

Results (tidy data set) goes into the directory "Project_2_Results", file name "Project2_Tidy.txt"

=======
p6
==

Getting And Cleaning Data Project
>>>>>>> 1396ef46e0fc469ed34c13b5917a90d53e3552e9
