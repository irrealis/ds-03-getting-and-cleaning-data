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

The following 66 variables correspond to a subset of variables from the original study. See section *Summary choices and study design* below for further details. ***These variables appear to be unitless***, according the statement "Features are normalized and bounded within [-1,1]" in the UCI HAR README (see file *UCI HAR Dataset.zip::UCI HAR Dataset/README.txt*), because normalization results in dimensionless quantities.

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


## Summary choices and study design:

These summarized measurements correspond to a subset of the variables from the UCI HAR study, consisting of means and standard deviations of the following study signals:

- Time-domain 3-axial signals:
    - `tBodyAcc-X/Y/Z`
    - `tGravityAcc-X/Y/Z`
    - `tBodyAccJerk-X/Y/Z`
    - `tBodyGyro-X/Y/Z`
    - `tBodyGyroJerk-X/Y/Z`
- Frequency-domain 3-axial signals:
    - `fBodyAcc-X/Y/Z`
    - `fBodyAccJerk-X/Y/Z`
    - `fBodyGyro-X/Y/Z`
- Time-domain magnitude signals:
    - `tBodyAccMag`
    - `tGravityAccMag`
    - `tBodyAccJerkMag`
    - `tBodyGyroMag`
    - `tBodyGyroJerkMag`
- Frequency-domain magnitude signals:
    - `fBodyAccMag`
    - `fBodyAccJerkMag`
    - `fBodyGyroMag`
    - `fBodyGyroJerkMag`

This choice of subset is based on step 2 of this project's instructions, which reads "Extracts only the measurements on the mean and standard deviation for each measurement." This is interpreted to mean "Extract only the estimates of the mean and standard deviation for each signal."

### Possible flaws in the design of this analysis:

- It appears that variably-weighted means are computed in this project, by design, where equally-weighted means were probably the intent of the project's designers.
- UCI HAR Dataset computations have not been shadowed for verification in this analysis, and probably should be. This was not done because it would be outside the scope of this project.

#### Variably-weighted means:

This project appears to compute variably-weighted averages of preprocessed signals from the UCI HAR Dataset. For each subject, activity, and variable, this project computes an average of means, and another of standard deviations, for data drawn from 50%-overlapping windows of 128 readings each (see *UCI HAR Dataset.zip::UCI HAR Dataset/README.txt*). This would imply that for each average:

- The first 64 readings are represented once, in the first half of the first window.
- The last 64 readings are represented once, in the last half of the last window.
- Every other reading is represented twice, by the overlap of adjacent windows, and thus has twice the weight of the first and last 64 readings.

#### Lack of verification of UCI HAR study:

A full analysis should include shadowing the computations of the UCI HAR Dataset for two reasons:

- In order to ensure full understanding of the study's measurement.
- In order to ensure that the study's measurements, which are used as this project's raw data, are themselves correct, based on the study's raw data.

This verification is not performed because it would be outside the scope of this project.
