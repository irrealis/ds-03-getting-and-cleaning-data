rawdat_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

features_fnm <- "features.txt"
act_lbls_fnm <- "activity_labels.txt"
trn_acts_fnm <- "y_train.txt"
tst_acts_fnm <- "y_test.txt"
trn_sbjs_fnm <- "subject_train.txt"
tst_sbjs_fnm <- "subject_test.txt"
trn_data_fnm <- "X_train.txt"
tst_data_fnm <- "X_test.txt"

raw_pth <- "UCI HAR Dataset.zip"
date_downloaded_pth <- "date_downloaded.txt"

zip_pth <- "UCI HAR Dataset"
trn_pth <- file.path(zip_pth, "train")
tst_pth <- file.path(zip_pth, "test")

features_pth <- file.path(zip_pth, features_fnm)
act_lbls_pth <- file.path(zip_pth, act_lbls_fnm)
trn_acts_pth <- file.path(trn_pth, trn_acts_fnm)
tst_acts_pth <- file.path(tst_pth, tst_acts_fnm)
trn_sbjs_pth <- file.path(trn_pth, trn_sbjs_fnm)
tst_sbjs_pth <- file.path(tst_pth, tst_sbjs_fnm)
trn_data_pth <- file.path(trn_pth, trn_data_fnm)
tst_data_pth <- file.path(tst_pth, tst_data_fnm)

join_col <- "activityid"
acts_col <- "activity"
sbjs_col <- "subject"


library(data.table)
library(lubridate)


dlts <- function(
    ts_fnm = date_downloaded_pth
){
    timestamp_file <- file(ts_fnm)
    open(timestamp_file, "r")
    ts <- readLines(timestamp_file)
    close(timestamp_file)
    ymd_hms(ts)
}

## zippedTable: read and return table from file 'data_fnm' in zip archive
## 'zip_fnme' using columns named in 'col.names', if specified. Optionally set
## 'stringsAsFactors = F' as in 'read.table'.
zippedTable <- function(data_fnm, zip_fnm, col.names, stringsAsFactors = T){
    data_file <- unz(zip_fnm, data_fnm)
    read.table(
        data_file,
        col.names = col.names,
        stringsAsFactors = stringsAsFactors
    )
}


## cachedTable: read and return table from 'cache_fnm' if present; otherwise,
## read from file 'data_fnm' in zip archive 'zip_fnme' using columns named in
## 'col.names', then save to 'cache_fnm', then reload and return from cache.
## Optionally set 'stringsAsFactors = F' as in 'read.table'.
cachedTable <- function(
    cache_fnm,
    data_fnm,
    zip_fnm,
    col.names,
    stringsAsFactors = T,
    ts_fnm = date_downloaded_pth
){
    if((!file.exists(cache_fnm)) | (file.info(cache_fnm)$ctime < dlts())){
        cat("Caching file:\n\t")
        cat(cache_fnm)
        cat("\n")
        zippedTable(data_fnm, zip_fnm, col.names, stringsAsFactors) %>%
          fwrite(cache_fnm)
    }
    fread(cache_fnm)
}


# Download and timestamp raw data if not present.
if(!file.exists(raw_pth)){
    cat("Raw datafile not present:\n\t")
    cat(rawdat_pth)
    cat("\n\nDownloading raw datafile from:\n\t")
    cat(rawdat_url)
    cat("\n\n")
    
    download.file(rawdat_url, destfile = raw_pth, method = "curl")
    date_downloaded <- now("UTC")
    dl_timestamp <- strftime(date_downloaded, usetz = T)
    write(dl_timestamp, file = date_downloaded_pth)

    cat(paste("\nDownload-timestamp", dl_timestamp, "written to file:\n\t"))
    cat(date_downloaded_pth)
    cat("\n\n")

    # We should remove cached data whenever we download new raw data.
    lapply(
        list(
            trn_acts_fnm,
            tst_acts_fnm,
            trn_sbjs_fnm,
            tst_sbjs_fnm,
            trn_data_fnm,
            tst_data_fnm
        ),
        function(x){
            if(file.exists(x)){
                cat("Removing old cache file:\n\t")
                cat(x)
                cat("\n")
                file.remove(x)
            }
        }
    )
}

## Extract feature-measurement variable names from raw-data archive.
# We only need second column, which we'll convert to variable names.
measured_vars <- zippedTable(features_pth, raw_pth, stringsAsFactors = F)[[2]]

#measured_vars <-
#  measured_vars %>%
#  sub(pattern = "^t", replacement = "timedomain") %>%
#  sub(pattern = "^f", replacement = "frequencydomain") %>%
#  sub(pattern = "AccJerk", replacement = "linearjerk") %>%
#  sub(pattern = "GyroJerk", replacement = "angularjerk") %>%
#  sub(pattern = "Acc", replacement = "linearacceleration") %>%
#  sub(pattern = "Gyro", replacement = "angularvelocity") %>%
#  sub(pattern = "Mag", replacement = "magnitude") %>%
#  sub(pattern = "std", replacement = "stddev")

## Read activities table from raw-data archive.
# We'll use first column for joins, and second column as activity levels.
acts_cols <- c(join_col, acts_col)
acts <- cachedTable(act_lbls_fnm, act_lbls_pth, raw_pth, acts_cols)

## Read training/test activities/subjects/dataset tables.
# Activities tables need the "activityid" column for later joins.
trn_acts <- cachedTable(trn_acts_fnm, trn_acts_pth, raw_pth, join_col)
tst_acts <- cachedTable(tst_acts_fnm, tst_acts_pth, raw_pth, join_col)
trn_sbjs <- cachedTable(trn_sbjs_fnm, trn_sbjs_pth, raw_pth, sbjs_col)
tst_sbjs <- cachedTable(tst_sbjs_fnm, tst_sbjs_pth, raw_pth, sbjs_col)
trn_data <- cachedTable(trn_data_fnm, trn_data_pth, raw_pth, measured_vars)
tst_data <- cachedTable(tst_data_fnm, tst_data_pth, raw_pth, measured_vars)

