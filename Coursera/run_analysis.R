run_analysis<-function(){
  library(dplyr)
  library(reshape2)
  
  setwd("C:/Users/Pavel/Desktop/UCI Har Dataset")
  
  #features is vector containing column names of variables for general data
  features<-read.table('features.txt')
  
  #Loading Test Data
  setwd("C:/Users/Pavel/Desktop/UCI Har Dataset/test")
  #Main data
  X_test<-read.table('X_test.txt')
  #Activity Label
  y_test<-read.table('y_test.txt')
  #Subject Identifier
  subject_test<-read.table('subject_test.txt')
  
  #Index values go from 1 to 2947
  index_test<-seq(1:nrow(X_test))
  
  #Applies Index to each test data set, ID for merging
  X_test<-cbind(index_test,X_test)
  y_test<-cbind(index_test,y_test)
  subject_test<-cbind(index_test,subject_test)
  
  #Merged Activity Label and Subject Identifier
  combined_test1<-merge(y_test,subject_test,by='index_test')
  
  #Merged Activity Label, Subject Identifier, and Data Set
  combined_test<-merge(combined_test1,X_test,by='index_test')
  
  #Loading Train Data
  setwd("C:/Users/Pavel/Desktop/UCI Har Dataset/train")
  #Main data
  X_train<-read.table('X_train.txt')
  #Activity Label
  y_train<-read.table('y_train.txt')
  #Subject Identifier
  subject_train<-read.table('subject_train.txt')
  
  #Index values go from 2948 to 10299, as train data set is added on to
  #test data set
  index_train<-seq(nrow(X_test)+1:nrow(X_train))
  
  #Applies Index to each test data set, ID for merging
  
  X_train<-cbind(index_train,X_train)
  y_train<-cbind(index_train,y_train)
  subject_train<-cbind(index_train,subject_train)
  
  #Merged Activity Label and Subject Identifier
  combined_train1<-merge(y_train,subject_train,by='index_train')
  
  #Merged Activity Label, Subject Identifier, and Data Set
  combined_train<-merge(combined_train1,X_train,by='index_train')
  
  #Index names are set to the same string so training and test data sets can be binded with
  #no error
  names(combined_test)[1]<-'index'
  names(combined_train)[1]<-'index'
  
  #Combining Training and Test Data sets
  combined_final<-rbind(combined_test,combined_train)
  
  #Labels column names
  names(combined_final)[2]<-"Activity_Label"
  names(combined_final)[3]<-'Subject_Identifier'
  names(combined_final)[4:564]<-features[,2]
  
  
  #Removes duplicated values from the data set; error while selecting would be received otherwise
  combined_final_nonduplicate <- combined_final[!duplicated(names(combined_final))]
  
  #Method to extract only 'mean' and 'std' values
  m<-'-mean()'
  s<-'-std()'
  #Extracts only unique variable names in features and combines with index into 
  #unique_features vector
  unique_features<-cbind(seq(1:477),as.character(unique(features[,2])))
  
  #Index Values that contain only mean measurements
  meanLogical<-grepl(m,unique_features[,2],fixed=TRUE)
  meanIndexValues<-unique_features[,1][meanLogical]
  
  #Index Values that contain only standard deviation measurements
  stdLogical<-grepl(s,unique_features[,2],fixed=TRUE)
  stdIndexValues<-unique_features[,1][stdLogical]
  
  #combined Index values of mean and standard deviation
  mean_std_IndexValues<<-as.numeric(c(meanIndexValues,stdIndexValues))
  
  #Each Index Value is increased by three because of index, activity label, and subject
  #identifier columns at the beginning of data frame
  mean_std_IndexValues_adjusted<<-mean_std_IndexValues+3
  
  #Selects index, activity label, subject identifier, mean, and standard deviation data
  mean_std_select<<-combined_final_nonduplicate %>% select(c(1,2,3,mean_std_IndexValues_adjusted))
  
  #Arranges data by Activity Label
  MSS<<-mean_std_select %>% arrange(Activity_Label)
  
  #Applies descriptive variable names
  names<-unique_features[,2][mean_std_IndexValues]
  names(MSS)[4:69]<-names
  
  #Melts data frame to have data on each subject as variable
  MSS_melted<-melt(MSS,id=c('Activity_Label','Subject_Identifier'),measure.vars=names)
  
  #Casts melted data frame to have mean variable value for each activity and subject
  MSS_FINAL<<-dcast(MSS_melted,Subject_Identifier+Activity_Label~variable,mean)
  
  #Changing Descriptive Activity Labels
  
  #First Replacement
  MSS_FINAL$Activity_Label<<-gsub(1,"WALKING",MSS_FINAL$Activity_Label)
  
  #Second Replacement
  MSS_FINAL$Activity_Label<<-gsub(2,"WALKING_UPSTAIRS",MSS_FINAL$Activity_Label)
  
  #Third Replacement
  MSS_FINAL$Activity_Label<<-gsub(3,"WALKING_DOWNSTAIRS",MSS_FINAL$Activity_Label)
  
  #Fourth Replacement
  MSS_FINAL$Activity_Label<<-gsub(4,"SITTING",MSS_FINAL$Activity_Label)
  
  #Fifth Replacement
  MSS_FINAL$Activity_Label<<-gsub(5,"STANDING",MSS_FINAL$Activity_Label)
  
  #Sixth Replacement
  MSS_FINAL$Activity_Label<<-gsub(6,"LAYING",MSS_FINAL$Activity_Label)
  
  #Writes table to file
  write.table(MSS_FINAL,file='TidyData.txt')
  
  
  
  
  
  
}