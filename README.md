## Repository Structure
This repository contains data collected from the accelerometers in the Samsung Galaxy S smartphone. The raw data
is in the folder named "UCI HAR Dataset". The changes I have made are in the top-level folder.

### Raw Data
Within the UCI HAR Dataset, there are several files and folders of note. "activity_labels.txt" matches the activities
performed with their activity ids. "features.txt" contains a list of all the variables measured. "features_info.txt" 
describes these variables in depth. "README.txt" explains the structure of the files in that originally constructed
archive. The test and train folders are structured similarly. The "subject" file contains subject ids for each of
the rows collected, "x" contains the actual measurements, and "y" lists the activity ids. The Inertial Signals 
folders contain finer data on several of the variables.

### Processed Data
At the top-level, there are the files that show how I changed the data. "CodeBook.md" describes both my final
results and how I got there. "run_analysis.r" is the script that provides the results. "TidyDataSet.csv" is the 
file containing the actual results.