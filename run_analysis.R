
if("matrixStats" %in% rownames(installed.packages()) == FALSE) 
  {install.packages("matrixStats")}

library(matrixStats)

# 1 step. Merges the training and the test sets to create one data set.

y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", header=F, quote="\"")
x_test<-read.table("./UCI HAR Dataset/test/x_test.txt", header=F, quote="\"")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", header=F, quote="\"")

rez_test<-cbind(y_test,subject_test, x_test)

y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", header=F, quote="\"")
x_train<-read.table("./UCI HAR Dataset/train/x_train.txt", header=F, quote="\"")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", header=F, quote="\"")
rez_train<-cbind(y_train,subject_train,x_train)

final_rez<-rbind(rez_test, rez_train)

names(final_rez)[1]<-paste("A1")
names(final_rez)[2]<-paste("A2")


# 2 step. Extracts only the measurements on the mean and standard deviation for each measurement. 


number_of_columns<-ncol(final_rez)
all_means<-colMeans(final_rez[3:number_of_columns])
all_dev<-colSds(as.matrix(final_rez[3:number_of_columns]))

# 3 step. Uses descriptive activity names to name the activities in the data set
# 4 step. Appropriately labels the data set with descriptive variable names.

labels1<-read.table("./UCI HAR Dataset/activity_labels.txt", header=F, quote="\"")
names(labels1)[1]<-paste("A1")

f<-c("Activities", "Label")

features_labels<-read.table("./UCI HAR Dataset/features.txt", header=F, quote="\"")
f_l<-as.vector(features_labels[[2]])

labels<-append(f,f_l)
colnames(final_rez)<-labels

mergedData=merge(labels1, final_rez, by.x="A1", by.y="Activities" )

mergedData$A1 <- NULL
names(mergedData)[1]<-paste("Activities")

# 5 step. From the data set in step 4, creates a second, independent tidy data set 
#         with the average of each variable for each activity and each subject.

aggdata <-aggregate(mergedData[3:ncol(mergedData)], by=list(mergedData$Label, mergedData$Activities), FUN=mean)

names(aggdata)[1]<-paste("Label")
names(aggdata)[2]<-paste("Activities")

write.table(aggdata, "final.txt", row.name=FALSE) 

print("That's all")
