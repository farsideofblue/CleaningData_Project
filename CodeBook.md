## Variables
This data set consists of measurements of body movement during different states. Each variable is measured in the 
time domain, signified by a t. A Fast Fourier Transform was also applied to many of them. These are marked by 
an f. Some variables were measured in the x, y, and z-axes, and are marked as such.

tBodyAccelerometer(XAxis, YAxis, ZAxix)              
tGravityAccelerometer(XAxis, YAxis, ZAxix)            
tBodyAccelerometerJerk(XAxis, YAxis, ZAxix)           
tBodyGyrometer(XAxis, YAxis, ZAxix)               
tBodyGyrometerJerk(XAxis, YAxis, ZAxix)          
tBodyAccelerometerMagnitude        
tGravityAccelerometerMagnitude      
tBodyAccelerometerJerkMagnitude     
tBodyGyrometerMagnitude              
tBodyGyrometerJerkMagnitude          
fBodyAccelerometer(XAxis, YAxis, ZAxix)          
fBodyAccelerometerJerk(XAxis, YAxis, ZAxix)            
fBodyGyrometer(XAxis, YAxis, ZAxix)              
fBodyAccelerometerMagnitude        
fBodyBodyAccelerometerJerkMagnitude
fBodyBodyGyrometerMagnitude        
fBodyBodyGyrometerJerkMagnitude    

For each variable, both the Mean and standard deviation (Std) are presented.

## Data Structure
The above variables are arranged by two sets of identifiers. The first is the activity during which the measurement was taken.
The activities are as follows:

LAYING
SITTING
STANDING
WALKING
WALKING_DOWNSTAIRS
WALKING_UPSTAIRS

The data set is further broken down by the subject performing the activities. The data set presents the average
value of each variable for each unique combination of subject and activity.

## Data Transformations and Cleanup
Several steps were taken to transform the data from its original raw state (located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

First, the test and train datasets were combined. Next, the measurement data was pared down so that it only included 
variables having to do with the mean or standard deviation. This excluded measurements relating to:

mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

In addition, several vectors included in the original data set measured average values of the angle() variables.
While these are Means of sorts, I decided they did not fit with the pattern of the other variables, and were excluded.

After this, the subject and activity information was joined to the measurement information. Variables were renamed
to fit the desired standards: every word is spelled out and demarcated with a capital letter, with the exception of
t (for time) and f (for frequency), one of which precedes every variable.

The next step melts the data together using the identifiers of subject and activity. Each variable is now stored
under the column heading "variable". Finally, the molten data is cast back into a data frame matching each unique
combination of subject and activity with its average for each variable.