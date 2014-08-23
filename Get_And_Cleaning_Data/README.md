---
title: "Get And Cleaning Analysis: runanalysis.R"
output: html_document
---

This document describe how **runanalysis.R** works.

The first lines just verify if necessary package is installed and if not install it.

```
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")
```

After that the script load the file and read the columns

```
load activity labels and data columns
activitylabels <- read.table("activitylabels.txt")[,2]
features <- read.table("features.txt")[,2]
```

Extract only the measurements on the mean and standard deviation for each measurement.
```
extractfeatures <- grepl("mean|std", features)
```

load and process Xtest & ytest data.

```
Xtest <- read.table("test/Xtest.txt")
ytest <- read.table("test/ytest.txt")
subjecttest <- read.table("test/subjecttest.txt")
names(Xtest) = features
Xtest = Xtest[,extractfeatures]
```

Load activity labels
```
ytest[,2] = activitylabels[ytest[,1]]
names(ytest) = c("ActivityID", "ActivityLabel")
names(subjecttest) = "subject"
```

bind data
```
testdata <- cbind(as.data.table(subjecttest), ytest, Xtest)
```

load and process Xtrain & ytrain data.
```
Xtrain <- read.table("train/Xtrain.txt")
ytrain <- read.table("train/ytrain.txt")
subjecttrain <- read.table("train/subjecttrain.txt")
names(Xtrain) = features
```
Extract only the measurements on the mean and standard deviation for each measurement.
```
Xtrain = Xtrain[,extractfeatures]
```

Load activity data
```
ytrain[,2] = activitylabels[ytrain[,1]]
names(ytrain) = c("ActivityID", "ActivityLabel")
names(subjecttrain) = "subject"
```

Bbind data
```
traindata <- cbind(as.data.table(subjecttrain), ytrain, Xtrain)
``` 

Merging
```
data = rbind(testdata, traindata)
idlabels = c("subject", "ActivityID", "ActivityLabel")
datalabels = setdiff(colnames(data), idlabels)
meltdata = melt(data, id = idlabels, measure.vars = datalabels)
´´´
Apply mean 
```
tidydata = dcast(meltdata, subject + ActivityLabel ~ variable, mean)
```
Write file tidy
```
write.table(tidydata, file = "tidydata.txt")
```