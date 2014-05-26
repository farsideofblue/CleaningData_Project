run_analysis <- function() {

  directory <- getwd()
  
  subject_test <- read.table(paste0(directory, "/UCI HAR Dataset/test/subject_test.txt"), quote="\"")
  subject_train <- read.table(paste0(directory, "/UCI HAR Dataset/train/subject_train.txt"), quote="\"")
  x_test <- read.table(paste0(directory, "/UCI HAR Dataset/test/X_test.txt"), quote="\"")
  y_test <- read.table(paste0(directory, "/UCI HAR Dataset/test/y_test.txt"), quote="\"")
  activity_labels <- read.table(paste0(directory, "/UCI HAR Dataset/activity_labels.txt"), quote="\"")
  x_train <- read.table(paste0(directory, "/UCI HAR Dataset/train/X_train.txt"), quote="\"")
  y_train <- read.table(paste0(directory, "/UCI HAR Dataset/train/y_train.txt"), quote="\"")  
  features <- read.table(paste0(directory, "/UCI HAR Dataset/features.txt"), quote="\"")
  
  x_test$dataType = "Test"
  x_train$dataType = "Train"
  
  x_all <- rbind(x_test, x_train)
  y_all <- rbind(y_test, y_train)
  subject_all = rbind(subject_test, subject_train)
  
  names(x_all) <- features[,2]  
  names(y_all) <- "activityCode"  
  names(subject_all) <- "subject"
  names(activity_labels) <- c("activityCode", "activity")
  
  #Check which columns meet the criteria to be included,
  #and store their indices in a vector called "columnsToKeep"
  columnsToKeep <- vector()
  
  for (i in 1:nrow(features) ){
    mean.present <- grep("mean", features[i,2])
    freq.present <- grep("Freq", features[i,2])
    std.present <- grep("std", features[i,2])
    if ( length(std.present) > 0 ){
      columnsToKeep <- c(columnsToKeep, i)
    } else if (length(mean.present) > 0 & length(freq.present) == 0){
      columnsToKeep <- c(columnsToKeep, i)
    }
  }
  
  #Add on the column for data type which is at the end
  columnsToKeep <- c(columnsToKeep, ncol(x_all))
    
  #Aren't they all mean? Yeah, I know. Sorry.
  x_allMeanSTD <- x_all[,columnsToKeep]
    
  
  allData <- cbind(subject_all, y_all, x_allMeanSTD)
  allData <- merge(allData, activity_labels)
  
  #This section makes the names more readable. Most words have been expanded, with the exception of t (for time)
  #and f (for frequency). I felt that adding these words in would not make the names more understandable
  names(allData) <- gsub("Acc", "Accelerometer", names(allData))
  names(allData) <- gsub("Gyro", "Gyrometer", names(allData))
  names(allData) <- gsub("-mean()", "Mean", names(allData), fixed = "TRUE")
  names(allData) <- gsub("-std()", "Std", names(allData), fixed = "TRUE")
  names(allData) <- gsub("-X", "Xaxis", names(allData))
  names(allData) <- gsub("-Y", "Yaxis", names(allData))
  names(allData) <- gsub("-Z", "Zaxis", names(allData))
  names(allData) <- gsub("Mag", "Magnitude", names(allData))
  
  library(reshape2)
  allData$rowNumber = 1:nrow(allData)
  orderData <- allData[,c(69:71, 2:68)]
  meltData <- melt(orderData, id = c("rowNumber", "subject", "activity"), measure.vars = names(orderData)[5:70])
  avgData <- dcast(meltData, subject + activity ~ variable, mean)
  
  write.csv(avgData, "TidyDataSet.csv")
  
}