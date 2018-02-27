# getting-and-cleaning-data

Final project for Coursera course "Getting and Cleaning Data" in the "Data Science" track from Johns Hopkins University.


## Goal:

This project summarizes the measured means and standard deviations in the *Human Activity Recognition Using Smartphones Data Set* from the UCI Machine Learning Repository. Details at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones (as of this project).


## Important files in this repository:

- *run_analysis.R*: the R script that performs this project's analysis.
- *uci_har_dataset_summary.txt*: the results of the analysis.
- *CodeBook.md*: a description of the data in *uci_har_dataset_summary.txt*, including the columns and their units, summary choices, and study design.


## The analysis script:

Analysis is performed by *run_analysis.R*, which requires dependent R library "`tidyr`", and which can be run if the dataset is in the working directory.


# Where to get the dataset:

The analysis script *run_analysis.R* will try to download the dataset if it isn't already present, and will save it to *UCI HAR Dataset.zip* in the working directory.

To download the file manually, try this link (as of this project): https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You can also look for a download link on dataset's webpage at the UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Save to *UCI HAR Dataset.zip* in the working directory.


## How to run the analysis:

From an R console in a terminal or in RStudio, type the following:
```R
source('run_analysis.R')
```

### How the script works:

- The dataset is downloaded if not present.
- Raw data are read from eight files the dataset. More on these files below.
- The raw data are merged into a single table for which:
  - Each row represents a set of measurements on observations of accelerometer and gyroscope data collected by a smartphone worn by a particular volunteer performing a particular activity. More on subjects, activities, and measurements below.
  - The columns represent:
    - The subject's ID.
    - The subject's activity.
    - A set of 561 measurements computed from accelerometer/gyroscope readings.
- 66 of the 561 measurement types are extracted, consisting of means and standard deviations. The rest are discarded.
- The 66 mean and standard-deviation measurement types are summarized as follows:
  - For each combination of subject, activity, and measurement type, all corresponding measurements are averaged.
  - A summary table is prepared, with:
    - A row for each combination of subject and activity.
    - One column of subject IDs.
    - One column of activity names.
    - 66 columns, for each of the measurement types.
- The summary table is written in tabular form to *uci_har_dataset_summary.txt*.
- *CodeBook.md* is updated with a description of all variables and summaries calculated, along with units and other relevant information.

### Intermediate files produced during analysis:

- *UCI HAR Dataset.zip*: archive containing the files comprising the *Human Activity Recognition Using Smartphones Data Set* .
- Cached files containing data extracted from the archive:
  - *features.txt*: labels for the 561 measurements computed in the dataset.
  - *activity_labels.txt*: labels for the activites in the dataset; this includes a join column of activity IDs for using in merging data.
  - *X_train.txt*: the training dataset, consisting of rows of 561 elements, each element corresponding to one of the 561 measurements, and to matching labels in *features.txt*.
  - *X_test.txt*: same as *X_train.txt*, but for the testing dataset.
  - *y_train.txt*: a list of activity IDs, which can be mapped to activity labels using *activity_labels.txt*; the nth row corresponds of this file corresponds to the nth row of *X_train.txt*.
  - *y_test.txt*: same as for *y_train.txt*, but for the testing dataset; the nth row of this file corresponds to the nth row of *X_test.txt*.
  - *subject_train.txt*: a list of subject IDs; the nth row corresponds of this file corresponds to the nth row of *X_train.txt*.
  - *subject_test.txt*: same as for *subject_train.txt*, but for the testing dataset; the nth row corresponds of this file corresponds to the nth row of *X_train.txt*.


### For more info on the dataset:

- See the dataset's web page at UCI Machine Learning Repository: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- After downloading the dataset, take a look at the following files:
  - *UCI HAR Dataset.zip::UCI HAR Dataset/README.txt*
  - *UCI HAR Dataset.zip::UCI HAR Dataset/features_info.txt*
