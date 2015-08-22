The script does the following steps to the data:

*Combines the activity labels, the subject identifier labels, with the training and test data sets, respectively.
*Combines the training and test data sets into one big data set.
*Removes duplicated variables in combined data set.
*Extracts only the mean and standard deviation measures from the resulting data set.
*Orders the data set by the values of the activity label.
*Sets names of variables as the variables in the features list.
*Melts the data set to have the ID as Activity Label and Subject Identifier and the variables as the measurement variables.
*Dcasts the melted data set to present the mean of each of the variables with IDs of Activity Label and Subject Identifier.
*Replaces Activity Label values with descriptive activity names.