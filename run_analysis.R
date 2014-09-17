# Getting and Cleaning Data - project

# read in train and test data
# assume train and test data are in working dir
#
Xtrain<-read.table("X_train.txt")
ytrain<-read.table("y_train.txt")
subjtrain<-read.table("subject_train.txt")

Xtest<-read.table("X_test.txt")
ytest<-read.table("y_test.txt")
subjtest<-read.table("subject_test.txt")


# step 1
# row-bind (train,test) to form one dataset
#
Xall<-rbind(Xtrain,Xtest)
yall<-rbind(ytrain,ytest)
subjall<-rbind(subjtrain,subjtest)


# step 2
# read in feature names and select names with mean() and std()
# assume features.txt is in working dir
#
fnames<-read.table("features.txt")
idmean<-grep("mean()",fnames$V2)
idstd<-grep("std()",fnames$V2)

# extract measurements on mean and std from Xall and corresponding labels
Xms<-Xall[,c(idmean,idstd)]
Xmslabel<-fnames[c(idmean,idstd),2]


# step 3
# read in activity labels and create act to change yall to activity labels
# assume activity_labels.txt is in working dir
#
actlabel<-read.table("activity_labels.txt")[,2]
act<-actlabel[yall$V1]


# step 4
# obtain no. of levels in subjall
nsubj<-levels(as.factor(subjall$V1))

# create subject label: 1 to subj1,..., 30 to subj30
subjlabel<-paste("subj",nsubj,sep="")

# create subject to change subjall using subjlabel
subject<-subjlabel[subjall$V1]

# apply Xmslabel to Xms
names(Xms)<-Xmslabel


# step 5
# create a subject by act list to be used in aggregate()
#
subj_act<-list(subject,act)
names(subj_act)<-c("subject","activity")

# compute average for each (subject,act) combination
# using aggregate()
data<-aggregate(Xms,subj_act,mean)

# write result to subjxact_mean.txt
# This dataset can be read using read.table("subjxact_mean.txt",header=T)
write.table(data,file="subjxact_mean.txt",row.names=FALSE)


