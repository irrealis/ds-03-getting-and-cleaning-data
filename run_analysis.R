## Required libraries.
library(tidyr)

## Names of cache files. Reason: these will contain data extracted from zip
## archive, which is a slow process. Once extracted and cached, loading from
## cache is much faster. But cached files must be removed when out of date.
features_fnm <- "features.txt"
act_lbls_fnm <- "activity_labels.txt"
trn_acts_fnm <- "y_train.txt"
tst_acts_fnm <- "y_test.txt"
trn_sbjs_fnm <- "subject_train.txt"
tst_sbjs_fnm <- "subject_test.txt"
trn_data_fnm <- "X_train.txt"
tst_data_fnm <- "X_test.txt"

## Where to store output tidy data.
tidy_data_fnm <- "uci_har_dataset_summary.txt"

## Where to save the code book.
code_book_fnm <- "CodeBook.md"

## Where to get raw data.
raw_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Filesystem paths.
## Path to cache raw data.
raw_pth <- "UCI HAR Dataset.zip"
## Path to timestamp file, recording when raw data was downloaded.
ts_pth <- "date_downloaded.txt"

## Paths within zip archive.
## Directory paths within zip archive.
zip_pth <- "UCI HAR Dataset"
trn_pth <- file.path(zip_pth, "train")
tst_pth <- file.path(zip_pth, "test")
## File paths within zip archive.
features_pth <- file.path(zip_pth, features_fnm)
act_lbls_pth <- file.path(zip_pth, act_lbls_fnm)
trn_acts_pth <- file.path(trn_pth, trn_acts_fnm)
tst_acts_pth <- file.path(tst_pth, tst_acts_fnm)
trn_sbjs_pth <- file.path(trn_pth, trn_sbjs_fnm)
tst_sbjs_pth <- file.path(tst_pth, tst_sbjs_fnm)
trn_data_pth <- file.path(trn_pth, trn_data_fnm)
tst_data_pth <- file.path(tst_pth, tst_data_fnm)

## Commonly-used column names.
join_col <- "activityid"
acts_col <- "activity"
sbjs_col <- "subject"
meas_col <- "measurement"
mean_col <- "mean"

## Whether to verify summarized means by direct computation from raw data. This
## is time-consuming, so disabled. Set to "T" to enable.
sanity_check_computed_means <- F


## Utility functions.

## zippedTable:
##
## Read and return table from file 'data_fnm' in zip archive 'zip_fnme' using
## columns named in 'col.names', if specified. Optionally set 'stringsAsFactors
## = F' as in 'read.table'.
##
## Arguments:
## - data_fnm: file to read from, contained in zip archive.
## - zip_fnm: zip archive to search for data file to read.
## - col.names: as in read.table, an optional set of column names.
## - stringsAsFactors: as in read.table, whether to convert character column
##   data to factors.
zippedTable <- function(data_fnm, zip_fnm, col.names, stringsAsFactors = T){
    data_file <- unz(zip_fnm, data_fnm)
    read.table(
        data_file,
        col.names = col.names,
        stringsAsFactors = stringsAsFactors
    )
}

## cachedTable:
##
## Read and return table from 'cache_fnm' if present; otherwise, read from file
## 'data_fnm' in zip archive 'zip_fnme' using columns named in 'col.names',
## then save to 'cache_fnm', then reload and return from cache.  Optionally set
## 'stringsAsFactors = F' as in 'read.table'.
##
## Arguments:
## - cache_fnm: cache file, to read data from (if cache file is present).
## - data_fnm: file to read from (if cache file is absent), contained in zip
##   archive.
## - zip_fnm: zip archive to search for data file to read.
## - col.names: as in read.table, an optional set of column names.
## - stringsAsFactors: as in read.table, whether to convert character column
##   data to factors.
cachedTable <- function(
    cache_fnm,
    data_fnm,
    zip_fnm,
    col.names,
    stringsAsFactors = T
){
    if(!file.exists(cache_fnm)){
        message("Caching file:\n\t", cache_fnm)
        zippedTable(data_fnm, zip_fnm, col.names, stringsAsFactors) %>%
          fwrite(cache_fnm)
    }
    message("Loading cached file:\n\t", cache_fnm)
    fread(cache_fnm)
}

## removeFileIfExists:
##
## Simple utility function to remove a file if it exists.
##
## Arguments:
## - filename: name of file to remove, if present.
removeFileIfExists <- function(filename){
    if(file.exists(filename)){
        message("Removing old file:\n\t", filename)
        file.remove(filename)
    }
}

## fetchRawDataIfMissing:
##
## Fetch raw data file if missing, in which case, record timestamp when
## downloaded, and remove out-of-date cache files.
##
## Arguments:
## - raw_fnm: where to save raw data, if it's missing.
## - raw_url: URL to use to fetch raw data.
## - ts_fnm: where to record when raw data was downloaded.
## - cached_files: files that should be considered out-of-date and removed, if
##   present when raw data is fetched.
fetchRawDataIfMissing <- function(raw_fnm, raw_url, ts_fnm, cached_files){
    if(!file.exists(raw_fnm)){
        message("Raw datafile not present:\n\t", raw_fnm)
        message("Downloading raw datafile from:\n\t", raw_url, "\n")
        
        download.file(raw_url, destfile = raw_fnm, method = "curl")
        date_downloaded <- now()
        ts <- strftime(date_downloaded, usetz = T)
        write(ts, file = ts_fnm)
    
        message("\nTimestamp ", ts, " written to file:\n\t", ts_fnm)
    
        # We should remove cached data whenever we download new raw data.
        lapply(cached_files, removeFileIfExists)
    }
}

## variableSubs:
##
## Specific to this analysis, this transforms variable names from the original
## to conform to tidy-data rules.
##
## Arguments:
## - var_names: the list of variable names to transform.
variableSubs <- function(var_names){
    var_names %>%
      sub(pattern = "^t", replacement = "timedom") %>%
      sub(pattern = "^f", replacement = "freqdom") %>%
      gsub(pattern = "std", replacement = "stddev") %>%
      gsub(pattern = "\\.", replacement = "") %>%
      tolower
}


## Begin analysis.

## Fetch raw data if missing, in which case, remove any cached data.
cached_files <- list(
    trn_acts_fnm, trn_sbjs_fnm, trn_data_fnm,
    tst_acts_fnm, tst_sbjs_fnm, tst_data_fnm
)
fetchRawDataIfMissing(raw_pth, raw_url, ts_pth, cached_files)

message("Loading raw data...")
## Extract feature-measurement variable names from raw-data archive.
## We only need second column, which we'll convert to variable names.
measured_vars <- zippedTable(features_pth, raw_pth, stringsAsFactors = F)[[2]]
## Read training/test activities/subjects/dataset tables.
trn_acts <- cachedTable(trn_acts_fnm, trn_acts_pth, raw_pth, join_col)
tst_acts <- cachedTable(tst_acts_fnm, tst_acts_pth, raw_pth, join_col)
trn_sbjs <- cachedTable(trn_sbjs_fnm, trn_sbjs_pth, raw_pth, sbjs_col)
tst_sbjs <- cachedTable(tst_sbjs_fnm, tst_sbjs_pth, raw_pth, sbjs_col)
trn_data <- cachedTable(trn_data_fnm, trn_data_pth, raw_pth, measured_vars)
tst_data <- cachedTable(tst_data_fnm, tst_data_pth, raw_pth, measured_vars)
## Read activities table from raw-data archive.
## We'll use first column for joins, and second column as activity levels.
act_columns <- c(join_col, acts_col)
act_labels <- cachedTable(act_lbls_fnm, act_lbls_pth, raw_pth, act_columns)
act_labels[[acts_col]] <- act_labels[[acts_col]] %>%
  tolower %>%
  gsub(pattern = "_", replacement = "")

## Combine trainting and test datasets.
message("Combining training and test datasets...")
data <- bind_rows(trn_data, tst_data)

## Extract only the "measurements on the mean and standard deviation of each
## measurement", which I take to mean "estimates of the mean and standard
## deviation for each signal".
data <- select(data, contains("mean"), contains("std"), -contains("angle"), -contains("freq"))
# Later, we'll use the corresponding original variable names to write docs.
original_vars <- data.table(measured_vars)[
    (measured_vars %like% "mean" | measured_vars %like% "std")
 & !(measured_vars %like% "angle")
 & !(measured_vars %like% "Freq")
]

## Rename variables according to the following rules:
## - Variable names should:
##   - Be lowercase if possible.
##   - Be descriptive ("diagnosis" vs "dx")
##   - Not be duplicated
##   - Not contain underscores, dots, or whitespace
names(data) <- names(data) %>% variableSubs
# Later, we'll use the cleaned variable names (in orig order) to write docs.
cleaned_vars <- original_vars %>% sapply(make.names) %>% variableSubs

## Summarize data.
message("Summarizing data...")
## Add subject and activity data.

#summary <- bind_cols(
merged_data <- bind_cols(

    ## Combine trainting and test subjects.
    bind_rows(trn_sbjs, tst_sbjs),
    ## Combine trainting and test activities.
    bind_rows(trn_acts, tst_acts),
    data
) %>%
  ## Add activity labels.
  merge(act_labels, by=join_col) %>%
  ## Remove activity IDs (used as join column).

  #select(-matches(join_col)) %>%
  select(-matches(join_col))
summary <- merged_data %>%

  ## Treat measurement column names as measurement values, and combine into
  ## "measurement" column.
  # "!!" is how to unquote meas/sbjs/acts_col when using gather.
  gather(key = !!meas_col, value = result, -!!sbjs_col, -!!acts_col) %>%
  ## Generate summary of measurement means, grouped by subject & activity.
  # ".dots = c()" is how to unquote meas/sbjs/acts_col when using group_by.
  group_by(.dots = c(sbjs_col, acts_col, meas_col)) %>%
  summarize(mean = mean(result)) %>%
  spread(measurement, mean) %>%
  setcolorder(c(sbjs_col, acts_col, cleaned_vars))


## Write summary to file.
message("Writing summary file:\n\t", tidy_data_fnm)
write.table(summary, tidy_data_fnm, row.name = F)


## Generate code book.
ungrouped_summary <- ungroup(summary)
unique_subjects <- unique(ungrouped_summary[[sbjs_col]])
number_of_subjects <- length(unique_subjects)
unique_activities <- unique(ungrouped_summary[[acts_col]])
number_of_activities <- length(unique_activities)
number_of_measurement_types <- nrow(original_vars)

## Sanify check: do means computed in summary match means for original data?
if(sanity_check_computed_means){
  message("Running sanity checks on summarized means...")
  for(s in unique_subjects){
    message("  ...checking for subject ", s, "...")
    for(a in unique_activities){
      message("    ...checking for activity ", a, "...")
      for(v in cleaned_vars){
        sanity_check <- mean(merged_data[subject == s & activity == a][[v]])
        actual <- summary[which(summary$subject == s & summary$activity == a),][[v]]
        if(actual != sanity_check){
          warning("computed mean mismatch: subject ", s, ", activity ", a, ", variable ", v, ", computed mean ", actual, " != expected ", sanity_check)
        }
      }
    }
  }
}


message("Analysis complete. Generating code book.")

cbf <- file(code_book_fnm)
open(cbf, "w")

cat(file = cbf, "# Code Book -- UCI HAR Dataset Summary\n\n")

cat(file = cbf, "## Variables:\n\n")

cat(file = cbf, paste0("`", sbjs_col, "`: integer ID numbers of UCI HAR study subjects, of which there are ", number_of_subjects, ".\n\n"))

cat(file = cbf, paste0("`", acts_col, "`: the subject's measured physical activity, of which there are the following ", number_of_activities, ".\n\n"))
for(a in unique_activities){
    cat(file = cbf, paste0("- `", a, "`\n"))
}
cat(file = cbf, "\n")


cat(file = cbf, paste0("The following ", number_of_measurement_types, " variables correspond to a subset of variables from the original study. See section *Summary choices and study design* below for further details. ***These variables appear to be unitless***, according the statement \"Features are normalized and bounded within [-1,1]\" in the UCI HAR README (see file *UCI HAR Dataset.zip::UCI HAR Dataset/README.txt*), because normalization results in dimensionless quantities.\n\n"))

for(i in seq_along(cleaned_vars)){
    cat(file = cbf, paste0("- `", cleaned_vars[i], "`: corresponds to `", original_vars[i], "`.\n\n"))
}
cat(file = cbf, "\n")

#cat(file = cbf, paste0("`", mean_col, "`: the computed mean (numeric) of all study measurements for this combination of subject, activity, and measurement type. Units are the same as those of corresponding variables in the original study. See section *Summary choices and study design* below for further details.\n\n"))

cat(file = cbf, "## Summary choices and study design:\n\n")

#cat(file = cbf, "The values in the \"mean\" column are averages computed for measurements for each combination of subject, activity, and measurement type. Here, the word \"measurement type\" corresponds to the term \"variable\" used in the raw dataset from the UCI HAR study (see file *UCI HAR Dataset.zip::UCI HAR Dataset/features_info.txt*), and also to the term \"variable\" used in step 5 of the instructions for this project.\n\n")

cat(file = cbf, "These summarized measurements correspond to a subset of the variables from the UCI HAR study, consisting of means and standard deviations of the following study signals:\n\n")
#
cat(file = cbf, "- Time-domain 3-axial signals:\n")
cat(file = cbf, "    - `tBodyAcc-X/Y/Z`\n")
cat(file = cbf, "    - `tGravityAcc-X/Y/Z`\n")
cat(file = cbf, "    - `tBodyAccJerk-X/Y/Z`\n")
cat(file = cbf, "    - `tBodyGyro-X/Y/Z`\n")
cat(file = cbf, "    - `tBodyGyroJerk-X/Y/Z`\n")
cat(file = cbf, "- Frequency-domain 3-axial signals:\n")
cat(file = cbf, "    - `fBodyAcc-X/Y/Z`\n")
cat(file = cbf, "    - `fBodyAccJerk-X/Y/Z`\n")
cat(file = cbf, "    - `fBodyGyro-X/Y/Z`\n")
cat(file = cbf, "- Time-domain magnitude signals:\n")
cat(file = cbf, "    - `tBodyAccMag`\n")
cat(file = cbf, "    - `tGravityAccMag`\n")
cat(file = cbf, "    - `tBodyAccJerkMag`\n")
cat(file = cbf, "    - `tBodyGyroMag`\n")
cat(file = cbf, "    - `tBodyGyroJerkMag`\n")
cat(file = cbf, "- Frequency-domain magnitude signals:\n")
cat(file = cbf, "    - `fBodyAccMag`\n")
cat(file = cbf, "    - `fBodyAccJerkMag`\n")
cat(file = cbf, "    - `fBodyGyroMag`\n")
cat(file = cbf, "    - `fBodyGyroJerkMag`\n")

cat(file = cbf, "\n")

cat(file = cbf, "This choice of subset is based on step 2 of this project's instructions, which reads \"Extracts only the measurements on the mean and standard deviation for each measurement.\" This is interpreted to mean \"Extract only the estimates of the mean and standard deviation for each signal.\"\n\n")

cat(file = cbf, "### Possible flaws in the design of this analysis:\n\n")

cat(file = cbf, "- It appears that variably-weighted means are computed in this project, by design, where equally-weighted means were probably the intent of the project's designers.\n")
cat(file = cbf, "- UCI HAR Dataset computations have not been shadowed for verification in this analysis, and probably should be. This was not done because it would be outside the scope of this project.\n\n")

cat(file = cbf, "#### Variably-weighted means:\n\n")

cat(file = cbf, "This project appears to compute variably-weighted averages of preprocessed signals from the UCI HAR Dataset. For each subject, activity, and variable, this project computes an average of means, and another of standard deviations, for data drawn from 50%-overlapping windows of 128 readings each (see *UCI HAR Dataset.zip::UCI HAR Dataset/README.txt*). This would imply that for each average:\n\n")

cat(file = cbf, "- The first 64 readings are represented once, in the first half of the first window.\n")
cat(file = cbf, "- The last 64 readings are represented once, in the last half of the last window.\n")
cat(file = cbf, "- Every other reading is represented twice, by the overlap of adjacent windows, and thus has twice the weight of the first and last 64 readings.\n\n")


cat(file = cbf, "#### Lack of verification of UCI HAR study:\n\n")

cat(file = cbf, "A full analysis should include shadowing the computations of the UCI HAR Dataset for two reasons:\n\n")

cat(file = cbf, "- In order to ensure full understanding of the study's measurement.\n")
cat(file = cbf, "- In order to ensure that the study's measurements, which are used as this project's raw data, are themselves correct, based on the study's raw data.\n\n")

cat(file = cbf, "This verification is not performed because it would be outside the scope of this project.\n")

close(cbf)

message("Done.")
