# Code Book -- UCI HAR Dataset Summary

## Variables:

`subject`: integer ID numbers of UCI HAR study subjects, of which there are 30.

`activity`: the subject's measured physical activity, of which there are the following 6.

- `laying`
- `sitting`
- `standing`
- `walking`
- `walkingdownstairs`
- `walkingupstairs`

`measurement`: measurement types, of which there are the following 66, corresponding to a subset of variables in the original study. See section *Summary choices and study design* below for further details.
- `timedombodyaccmeanx`: corresponds to `tBodyAcc-mean()-X`.

- `timedombodyaccmeany`: corresponds to `tBodyAcc-mean()-Y`.

- `timedombodyaccmeanz`: corresponds to `tBodyAcc-mean()-Z`.

- `timedombodyaccstddevx`: corresponds to `tBodyAcc-std()-X`.

- `timedombodyaccstddevy`: corresponds to `tBodyAcc-std()-Y`.

- `timedombodyaccstddevz`: corresponds to `tBodyAcc-std()-Z`.

- `timedomgravityaccmeanx`: corresponds to `tGravityAcc-mean()-X`.

- `timedomgravityaccmeany`: corresponds to `tGravityAcc-mean()-Y`.

- `timedomgravityaccmeanz`: corresponds to `tGravityAcc-mean()-Z`.

- `timedomgravityaccstddevx`: corresponds to `tGravityAcc-std()-X`.

- `timedomgravityaccstddevy`: corresponds to `tGravityAcc-std()-Y`.

- `timedomgravityaccstddevz`: corresponds to `tGravityAcc-std()-Z`.

- `timedombodyaccjerkmeanx`: corresponds to `tBodyAccJerk-mean()-X`.

- `timedombodyaccjerkmeany`: corresponds to `tBodyAccJerk-mean()-Y`.

- `timedombodyaccjerkmeanz`: corresponds to `tBodyAccJerk-mean()-Z`.

- `timedombodyaccjerkstddevx`: corresponds to `tBodyAccJerk-std()-X`.

- `timedombodyaccjerkstddevy`: corresponds to `tBodyAccJerk-std()-Y`.

- `timedombodyaccjerkstddevz`: corresponds to `tBodyAccJerk-std()-Z`.

- `timedombodygyromeanx`: corresponds to `tBodyGyro-mean()-X`.

- `timedombodygyromeany`: corresponds to `tBodyGyro-mean()-Y`.

- `timedombodygyromeanz`: corresponds to `tBodyGyro-mean()-Z`.

- `timedombodygyrostddevx`: corresponds to `tBodyGyro-std()-X`.

- `timedombodygyrostddevy`: corresponds to `tBodyGyro-std()-Y`.

- `timedombodygyrostddevz`: corresponds to `tBodyGyro-std()-Z`.

- `timedombodygyrojerkmeanx`: corresponds to `tBodyGyroJerk-mean()-X`.

- `timedombodygyrojerkmeany`: corresponds to `tBodyGyroJerk-mean()-Y`.

- `timedombodygyrojerkmeanz`: corresponds to `tBodyGyroJerk-mean()-Z`.

- `timedombodygyrojerkstddevx`: corresponds to `tBodyGyroJerk-std()-X`.

- `timedombodygyrojerkstddevy`: corresponds to `tBodyGyroJerk-std()-Y`.

- `timedombodygyrojerkstddevz`: corresponds to `tBodyGyroJerk-std()-Z`.

- `timedombodyaccmagmean`: corresponds to `tBodyAccMag-mean()`.

- `timedombodyaccmagstddev`: corresponds to `tBodyAccMag-std()`.

- `timedomgravityaccmagmean`: corresponds to `tGravityAccMag-mean()`.

- `timedomgravityaccmagstddev`: corresponds to `tGravityAccMag-std()`.

- `timedombodyaccjerkmagmean`: corresponds to `tBodyAccJerkMag-mean()`.

- `timedombodyaccjerkmagstddev`: corresponds to `tBodyAccJerkMag-std()`.

- `timedombodygyromagmean`: corresponds to `tBodyGyroMag-mean()`.

- `timedombodygyromagstddev`: corresponds to `tBodyGyroMag-std()`.

- `timedombodygyrojerkmagmean`: corresponds to `tBodyGyroJerkMag-mean()`.

- `timedombodygyrojerkmagstddev`: corresponds to `tBodyGyroJerkMag-std()`.

- `freqdombodyaccmeanx`: corresponds to `fBodyAcc-mean()-X`.

- `freqdombodyaccmeany`: corresponds to `fBodyAcc-mean()-Y`.

- `freqdombodyaccmeanz`: corresponds to `fBodyAcc-mean()-Z`.

- `freqdombodyaccstddevx`: corresponds to `fBodyAcc-std()-X`.

- `freqdombodyaccstddevy`: corresponds to `fBodyAcc-std()-Y`.

- `freqdombodyaccstddevz`: corresponds to `fBodyAcc-std()-Z`.

- `freqdombodyaccjerkmeanx`: corresponds to `fBodyAccJerk-mean()-X`.

- `freqdombodyaccjerkmeany`: corresponds to `fBodyAccJerk-mean()-Y`.

- `freqdombodyaccjerkmeanz`: corresponds to `fBodyAccJerk-mean()-Z`.

- `freqdombodyaccjerkstddevx`: corresponds to `fBodyAccJerk-std()-X`.

- `freqdombodyaccjerkstddevy`: corresponds to `fBodyAccJerk-std()-Y`.

- `freqdombodyaccjerkstddevz`: corresponds to `fBodyAccJerk-std()-Z`.

- `freqdombodygyromeanx`: corresponds to `fBodyGyro-mean()-X`.

- `freqdombodygyromeany`: corresponds to `fBodyGyro-mean()-Y`.

- `freqdombodygyromeanz`: corresponds to `fBodyGyro-mean()-Z`.

- `freqdombodygyrostddevx`: corresponds to `fBodyGyro-std()-X`.

- `freqdombodygyrostddevy`: corresponds to `fBodyGyro-std()-Y`.

- `freqdombodygyrostddevz`: corresponds to `fBodyGyro-std()-Z`.

- `freqdombodyaccmagmean`: corresponds to `fBodyAccMag-mean()`.

- `freqdombodyaccmagstddev`: corresponds to `fBodyAccMag-std()`.

- `freqdombodybodyaccjerkmagmean`: corresponds to `fBodyBodyAccJerkMag-mean()`.

- `freqdombodybodyaccjerkmagstddev`: corresponds to `fBodyBodyAccJerkMag-std()`.

- `freqdombodybodygyromagmean`: corresponds to `fBodyBodyGyroMag-mean()`.

- `freqdombodybodygyromagstddev`: corresponds to `fBodyBodyGyroMag-std()`.

- `freqdombodybodygyrojerkmagmean`: corresponds to `fBodyBodyGyroJerkMag-mean()`.

- `freqdombodybodygyrojerkmagstddev`: corresponds to `fBodyBodyGyroJerkMag-std()`.


`mean`: the computed mean (numeric) of all study measurements for this combination of subject, activity, and measurement type. Units are the same as those of corresponding variables in the original study. See file *README.md* for further details.

## Summary choices and study design:

The values in the "mean" column are averages computed for measurements for each combination of subject, activity, and measurement type. Here, the word "measurement type" corresponds to the term "variable" used in the raw dataset from the UCI HAR study (see file *UCI HAR Dataset.zip::UCI HAR Dataset/features_info.txt*), and also to the term "variable" used in step 5 of the instructions for this project.

The summarized measurement types correspond to a subset of the variables in the UCI HAR study. The subset chosen for this summary consists of means and standard deviations for the following signals from the study:

- Time-domain 3-axial signals:
    - tBodyAcc-X/Y/Z
    - tGravityAcc-X/Y/Z
    - tBodyAccJerk-X/Y/Z
    - tBodyGyro-X/Y/Z
    - tBodyGyroJerk-X/Y/Z
- Frequency-domain 3-axial signals:
    - fBodyAcc-X/Y/Z
    - fBodyAccJerk-X/Y/Z
    - fBodyGyro-X/Y/Z
- Time-domain magnitude signals:
    - tBodyAccMag
    - tGravityAccMag
    - tBodyAccJerkMag
    - tBodyGyroMag
    - tBodyGyroJerkMag
- Frequency-domain magnitude signals:
    - fBodyAccMag
    - fBodyAccJerkMag
    - fBodyGyroMag
    - fBodyGyroJerkMag

This choice of measurement types to summarize is based on step 2 of the instructions for this project, which reads "Extracts only the measurements on the mean and standard deviation for each measurement." For this project, this instruction is interpreted to mean "Extract only the estimates of the mean and standard deviation for each signal."

### Possible flaws in analysis:

The means computed in this analysis appear to be, essentially, variably-weighted means of preprocessed signals from the UCI HAR dataset. However, from the instructions given for this project, it appears that *equally*-weighted means are intended.

For each subject, activity, and variable, it appears that this analysis of means of means, and means of standard deviations, for data drawn from overlapping windows of 128 readings per window (see *UCI HAR Dataset.zip::UCI HAR Dataset/README.txt*). This would mean that in our means:

- The first 64 readings are represented once, by the first window.
- The last 64 readings are represented once, by the last window.
- Every other reading is represented twice, by the overlap of adjacent windows.
