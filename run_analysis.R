## Required libraries.
#library(data.table)
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
tidy_data_fnm <- "summary.txt"

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
data <- bind_rows(
    trn_data,
    tst_data,
)

## Extract only the "measurements on the mean and standard deviation of each
## measurement", which I take to mean "estimates of the mean and standard
## deviation for each signal".
data <- select(data, contains("mean"), contains("std"), -contains("angle"), -contains("freq"))

## Rename variables according to the following rules:
## - Variable names should:
##   - Be lowercase if possible.
##   - Be descriptive ("diagnosis" vs "dx")
##   - Not be duplicated
##   - Not contain underscores, dots, or whitespace
original_vars <- names(data)
cleaned_vars <-
  names(data) %>%
  sub(pattern = "^t", replacement = "timedomain") %>%
  sub(pattern = "^f", replacement = "frequencydomain") %>%
  gsub(pattern = "std", replacement = "standarddeviation") %>%
  gsub(pattern = "\\.", replacement = "") %>%
  tolower

names(data) <- cleaned_vars

## Summarize data.
message("Summarizing data...")
## Add subject and activity data.
summary <- bind_cols(
    ## Combine trainting and test subjects.
    bind_rows(trn_sbjs, tst_sbjs),
    ## Combine trainting and test activities.
    bind_rows(trn_acts, tst_acts),
    data
) %>%
  ## Add activity labels.
  merge(act_labels, by=join_col) %>%
  ## Remove activity IDs (used as join column).
  select(-matches(join_col)) %>%
  ## Treat measurement column names as measurement values, and combine into
  ## "measurement" column.
  gather(key = !!meas_col, value = result, -!!sbjs_col, -!!acts_col) %>%
  ## Generate summary of measurement means, grouped by subject & activity.
  group_by(.dots = c(sbjs_col, acts_col, meas_col)) %>%
  summarize(mean = mean(result))

# Write summary to file.
message("Writing summary file:\n\t", tidy_data_fnm)
write.table(summary, tidy_data_fnm, row.name = F)
