# Code Book

This document provides information about the generated data sets and by the script `run_analysis.R`.

## 1. Source Data
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The data itself was obtained through this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), which contains a zip file containing all the files needed to execute the R script.

## 2. Extraction
The R script automatically downloads the zip file and unzips it.
Then it reads the features from the `features.txt` file and selects only the measurements on the mean and standard deviation. It proceeds by changing the features labels to more descriptive names:
* 't' is replaced by 'time';
* 'f' is replaced by 'frequency';
* 'mean' is replaced by 'Mean';
* 'std' is replaced by 'Std';
* all parenthesis and dashes are removed.

It reads the `activity_labels.txt` file to append them to the data set in the merge step.

Then, for each data set: test and training, it does the following:

1. Read subjects (`subject_test.txt` or `subject_train.txt`);
2. Read activities (`Y_test.txt` or `Y_train.txt`);
3. Read only the features mentioned in the extraction chapter from the sensor signals files (`X_test.txt` or `X_train.txt`);
4. Merge subjects, activities and sensor signals into one data set: `test` or `training`;
5. Names the data set according with the features file.

## 3. Merge
In this stage, the R script will merge both data sets, `test` and `training` into one data set: `merge`.
After that, it will assign descriptive activity names.

## 4. Aggregation
The last stage is where a tidy data set named `tidyData` is created by aggregating the data by subject and activity and calculating the mean of the other variables.
