# Project 2 - Getting and Cleaning Data

# The purpose of this project is to demonstrate your ability to collect, work with, 
# and clean a data set. The
# goal is to prepare tidy data that can be used for later analysis.
# You will be graded by your peers on a series
# of yes/no questions related to the project.
# You will be required to submit:
#   1) a tidy data set as described
# below,
# 2) a link to a Github repository with your script for performing the analysis,
# and 3) a code book that describes the variables, the data, 
# and any transformations or work that you performed to clean up the data
# called CodeBook.md. 
# 
# You should also include a README.md in the repo with your scripts.
# This repo explains how all of the scripts work and how they are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing
# - see for example this article . Companies like Fitbit, Nike, and Jawbone Up
# are racing to develop the most advanced algorithms
# to attract new users. 
# The data linked to from the course website represent data collected from the
# accelerometers from the Samsung Galaxy S smartphone.
# A full description is available at the site where
# the data was obtained:
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Here are the data for the project:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# You should create one R script called run_analysis.R that does the following.


# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
# for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average
# of each variable for each activity and each subject



# Assumptions
#The  folder with unzipped files, "UCI HAR Dataset" is in the current working directory
# Input File names are identical to the original data set

# Step 1: Combine into a single data frame
# 
# Developing the R script
# 
# The  folder with unzipped files, "UCI HAR Dataset" is in the current working directory


#Check if you can open the sub directory
# getwd()

message("Please ensure  that the unzipped data sub-dir 'UCI HAR Dataset' is in this directory")

uciDir = "UCI HAR Dataset"

if (file.exists(uciDir)) {
  message("Taking data from sub directory ", uciDir)
  
} else 
  {
    message("Not able to locate sub directory ", uciDir)  
  }


#Results directory

p2Results = "Project_2_Results"

#getwd()

if (file.exists(p2Results)) {
  message(" Results directory exists: ", p2Results)
} else {
  message("Creating subdirectory for results: ", p2Results)
  dir.create(file.path(p2Results))
  if (file.exists(p2Results)){
    message(" Successfully created a sub-directory to hold results: ", file.path(p2Results))
  }
}
#Get  a list of files in uciDir

#list.files(uciDir)

testDir = file.path(uciDir, "test")
# testDir
# list.files(testDir)

trainDir = file.path(uciDir, "train")
# trainDir
# list.files(trainDir)


#Merge the subject Train and Test files, and convert them into data frames

sTrain <- file.path(trainDir, "subject_train.txt")
sTrain.df <- read.table(sTrain)
# names(sTrain.df)
# nrow(sTrain.df)

sTest <- file.path(testDir, "subject_test.txt")
sTest.df <- read.table(sTest)
# names(sTest.df)
# nrow(sTest.df)

#Bind them - TEST data comes first, before TRAINING
#Maintain this order

sAll.df <- rbind(sTest.df, sTrain.df)
# names(sAll.df)
# nrow(sAll.df)

# nrow(sTrain.df)+nrow(sTest.df)
# head(sAll.df)

#Try writing into Results directory

# ?write.table()
# 
# sOutFile <- file.path(p2Results, "subject_All.txt")
# 
# write.table(sAll.df, sOutFile)
# 
# names(sAll.df)

#Make the name of subject df into something readable

names(sAll.df) <- "Subject_ID"

#names(sAll.df)


#Verify your  write of subject_All.txt

# ts1 <- read.table(sOutFile)
# message("Writing subject_All.text succeeded? ", (nrow(ts1) == nrow(sAll.df)))
# rm(ts1)




#Now, combine the training and test sets of X

#testDir

xf1 <- file.path(testDir,"X_test.txt")

#xf1
xdf1 <- read.table(xf1)

# names(xdf1)
# nrow(xdf1)
# xdf1[1:5,1:5]

yf1 <- file.path(testDir, "Y_test.txt")
# yf1
# ydf1 <- read.table(yf1)
# names(ydf1)
# nrow(ydf1)
# ydf1[1:5,]

# trainDir


xf2 <- file.path(trainDir, "X_train.txt")

#xf2

xdf2 <- read.table(xf2)
# names(xdf2)
# nrow(xdf2)

yf2 <- file.path(trainDir, "Y_train.txt")

#yf2

ydf2 <- read.table(yf2)
# names(ydf2)
# nrow(ydf2)

#Merge the X- data frames

xAll.df <- rbind(xdf1, xdf2)
# nrow(xAll.df)
# message("Is xAll.df the same size as xdf1+xdf2? ", (nrow(xAll.df) == nrow(xdf1)+nrow(xdf2)))

#Merge the Y-data frames

yAll.df <- rbind(ydf1, ydf2)
# nrow(yAll.df)
# message("Is yAll.df the same size as ydf1+ydf2? ", (nrow(yAll.df) == nrow(ydf1)+nrow(ydf2)))


#Merge the full X and Y  df's

 xyAll.df <- cbind(xAll.df, yAll.df)
# dim(xyAll.df); dim(xAll.df); dim(yAll.df)
# names(xyAll.df)

#Merge the subject df at the right most

xys.df <- cbind(xyAll.df, sAll.df)
#dim(xys.df); dim(xyAll.df); dim(sAll.df)

#Get the features list
f1 <- file.path(uciDir,"features.txt")
ftr1 <- read.table(f1)
# names(ftr1)
# nrow(ftr1)
# ftr1[1:20,]


#Get the activity labels list
a2 <- file.path(uciDir, "activity_labels.txt")
actLabel.df <- read.table(a2)


# names(actLabel.df)
# nrow(actLabel.df)
# #actLabel.df[1:5,]
# actLabel.df


#Take out the activity label text in column 2
aL2 <- actLabel.df[,2]


#Make the names of xAll the same as 2nd column of ftr1

# length(ftr1[,2])
# length(xAll.df)

#Replace the cryptic names in X-data frame with descriptive names
names(xAll.df) <- ftr1[,2]

# names(xAll.df)
# 
# 
# head(yAll.df)
# names(yAll.df)
# names(yAll.df) <- "y_activity_Label"
# names(yAll.df)
# head(yAll.df)



#Replace yAll.df by yNew.df
#Lookup the value of yAll.df[i]; yInx <- yAll.df[i]
#Use this as an index into actLabel.df
# acType <- actLabel.df[yInx]

#Replace yAll.df[i] by acType

#Try the logic
# v1 <- c(1, 2, 3, 2, 1)
# 
# v2 <- c(10, 40, 90)
# 
# v3 <- v2[v1]
# 
# v3

#Turned out to be 10 40 90 40 10, so it works!

# head(yAll.df)
# names(yAll.df)
# head(yAll.df[,1])



#THis is a critical step - make a new Y vector, replacing the activity code by it description

yNew <- aL2[yAll.df[,1]]

# length(yNew)
# 
# head(yNew)
# names(yNew)


#?data.frame
#Make it a  data frame

yNew.df <- data.frame(yNew)
# dim(yNew.df); names(yNew.df)
names(yNew.df) <- "ActivityLabel"  
# names(yNew.df)

#Put them all together

xys.df <- cbind(xAll.df, yNew.df,sAll.df)

# dim(xys.df); 
# names(xys.df)

#Step 1 is done,
#we have  data frame of all x, y (with activity label), and subject id

#Step 2
#Extracts only the measurements on the mean and standard deviation for each measurement.


#Exract the list of xNames
xNames <- names(xAll.df)
#length(xNames); head(xNames)

#Get an indicator array of whether the name contains "mean"
#Test it

rv1 <- grepl("mean", xNames, ignore.case = TRUE)
#rv1

#now, for "std"
rv2 <- grepl("std", xNames, ignore.case = TRUE)
#rv2

rv3 <- rv1 | rv2
# length(rv3)
# table(rv3)


#Subset xAll by rv3

#?subset

x2All.df <- subset(xAll.df, ,rv3)
# dim(x2All.df); 
# names(x2All.df)


xys2.df <- cbind(x2All.df, yNew.df, sAll.df)
# dim(xys2.df); length(names(xys2.df))
# names(xys2.df)

#Now we have all the data in one DF with descriptive names

#Step 2 Done

#Step 3 Start: Uses descriptive activity names to name the activities in the data set

# Replaced activity code numbers  with activity names

# Step 3 end

#Step 4 start

# Replaced names of X-vector with descriptive names
# Step 4 - Done

#Step 5 start: Creates a second, independent tidy data set with the average of each variable for each activity and
#each subject.

#?data.table

library(plyr)

#?ddply




#Use ddply as explained in the lectur 

p5tidy.df <- ddply(xys2.df,.(ActivityLabel, Subject_ID),numcolwise(mean) ) 
# dim(p5tidy.df);
# head(p5tidy.df)[,1:3]



#You have to write it to a file

p2TidyFile <- file.path(p2Results, "Project2_Tidy.txt")

write.table(p5tidy.df, p2TidyFile,row.name = FALSE)



#Verify your  write of subject_All.txt

# ts1 <- read.table(p2TidyFile)
# message("Writing Project2_Tidy.txt succeeded? ", (nrow(ts1) == nrow(p5tidy.df)))
# rm(ts1)


#Step 5 Done



