# Welcome to main R script CodeBook

The R script have 5 steps.

### 1 step. Merges the training and the test sets to create one data set.

###Variables

Variable      | Description
--------------|------------
y_test        |Store setsfrom y_test.txt file
x_test        |Store sets from X_test.txt file
subject_test  |Store sets from subject_test.txt file
rez_test      |Store merged test sets
y_train       |Store sets from y_train.txt file
x_train       |Store sets from X_train.txt file
subject_train |Store sets from subject_train.txt file
rez_train     |Store merged train sets
final_rez     |Store merged test and train sets

###Comment for this step

When merged the all sets, some column names are similar.
![First picture][id]

I'm using two commands to change coplumn names. It will be necessary in the future

```{r}
names(final_rez)[1]<-paste("A1")
names(final_rez)[2]<-paste("A2")
```
### 2 step. Extracts only the measurements on the mean and standard deviation for each measurement. 

###Variables

Variable            | Description
--------------------|------------
number_of_columns   | Number of columns of final set.
all_means           | Means for each column (measurement)
all_dev             | Standart deviation for each column (measurement)

###Comment for this step

```
colSds required library(matrixStats). Standard deviation estimates for each row (column) in a matrix.
```

We starting to calculate from 3th column to end.

```{r}
number_of_columns<-ncol(final_rez)
all_means<-colMeans(final_rez[3:number_of_columns])
all_dev<-colSds(as.matrix(final_rez[3:number_of_columns]))

```
### 3 step. Uses descriptive activity names to name the activities in the data set
### 4 step. Appropriately labels the data set with descriptive variable names.

###Variables

Variable            | Description
--------------------|------------
labels1             | Store data sets from activity_labels.txt file.
f                   | Names of first two data column.
f_l                 | Convert features_labels to vector.
labels              | Merge labels from f and f_l variables.
mergedData          | Merge and store final datasets and column name 

###Comment for this step

Simple R code change first final date column name to **Activities**
```{r}
mergedData$A1 <- NULL
names(mergedData)[1]<-paste("Activities")
```
### 5 step. From the data set in step 4, creates a second, independent tidy data set  with the average of each variable for each activity and each subject.

###Variables

Variable            | Description
--------------------|------------
aggdata             | Store final agregate data.

Restore two column names and write data from variable aggdata to file final.txt.
```{r}
names(aggdata)[1]<-paste("Label")
names(aggdata)[2]<-paste("Activities")
write.table(aggdata, "final.txt", row.name=FALSE) 
```
## Result
![Second][id1]

![Finish][id2]

[id]:figures/first.PNG "First picture"
[id1]:figures/second.PNG "Second"
[id2]:http://static6.depositphotos.com/1150740/642/v/950/depositphotos_6420662-Finishing-runner-with-finished-ribbon.jpg "Finish"