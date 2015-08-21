# cleaningdataproject
Getting and Cleaning Data (Coursera) Project with Samsung Galaxy data sets
============================

Here is the basic description of the UCI HAR data set:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Below is a summary of the steps contained in run_analysis.R to be performed on this data set, with the ultimate goal of creating a tidy data set that contains a mean for each mean and standard deviation variable, for each subject and activity.

1. The script begins by preparing the test and train data to be merged.  
2. Before they can be merged, the script combines each with the relevant subject data, and renames variables as needed to ensure a match.  
3. Once this is complete, the training and test data are combined into one data table.  
4. From this full table, the script takes a subset of the data, containing the desired mean and standard deviation variables, as well as subject id and activity name.  *The script considers varibles that end in 'mean()' or 'std()' to fit these requirements*. 
5. These are then combined to form the tidy data set, and variables are renamed to be more clear and consistent.  
6. This data is melted and cast (using the reshape package), to aggregate an average for each subject and activity. 
7. Finally, this completed data table is written to a text file named "tidygalaxydataset.txt" using write.table(). 