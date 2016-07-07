#load packages
library(reshape2)
library(dplyr)
library(tidyr)
library(curl)

#read all data
if(!file.exists("./samsungdata")){dir.create("./samsungdata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(fileurl, "./samsungdata/zippeddata.zip") 
unzip(zipfile="./samsungdata/zippeddata.zip",exdir="./samsungdata") 

#set base file path
basefilepath<-file.path(".","samsungdata","UCI HAR Dataset")
setwd(basefilepath)


##Read Test data and related
testdata<-read.table("./test/x_test.txt")
testactivity<-read.table("./test/y_test.txt")
testsubject<-read.table("./test/subject_test.txt")

##read train data and releated
traindata<-read.table("./train/x_train.txt")
trainactivity<-read.table("./train/y_train.txt")
trainsubject<-read.table("./train/subject_train.txt")


##read activity data and features
activitydesc<-read.table("./activity_labels.txt")
features<-read.table("./features.txt")


#bind subject and activity data to test data
testdatacomplete<-cbind(testsubject,testactivity,testdata)

#bind subject and activity data to train data
traindatacomplete<-cbind(trainsubject,trainactivity,traindata)

#bind the test and train data to get full data set
fulldataset<-rbind(traindatacomplete,testdatacomplete)

#get all names for the columns
variablenames<-c("subject","activity",as.character(features[,2]))
colnames(fulldataset)<-variablenames

#get subset names vector from features for mean and std in addition to the subject
reqfeaturenames<-features$V2[grep("mean\\(\\)|std\\(\\)",features[,2])]
allfeaturenames<-c("subject","activity",as.character(reqfeaturenames))

#subset the full data to get the required data
reqdata<-subset(fulldataset,select=allfeaturenames)


#replace t and f to time and frequency domain
names(reqdata)<-gsub("^t","time",names(reqdata))
names(reqdata)<-gsub("^f","frequency",names(reqdata))

#Replace mean() and std() functions to indicate mean and std fuction
names(reqdata)<-gsub('[()]','',names(reqdata))

#fix possible mistake in the name with duplicate word body
names(reqdata)<-gsub("BodyBody","Body",names(reqdata))

#set subject and activity as factors
reqdata$subject<-as.factor(reqdata$subject)
reqdata$activity<-factor(reqdata$activity,levels=activitydesc[,1],labels=activitydesc[,2])

#create independent tidy data set with the average of each variable for each activity and each subject.
melteddata <- melt(reqdata, id = c("subject", "activity"))
melteddatamean<-dcast(melteddata,subject + activity ~ variable,mean)

#create tidy data txt file
write.table(melteddatamean, file = "tidydata.txt",row.name=FALSE)