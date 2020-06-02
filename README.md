# Course Project
This is the final course project for Getting and Cleaning Data in R. 

I've broken up my code into different segments. 

For the first part, I download the file into R and I check that the file and the folder within it exist. 
Secondly, I load every table from the documents within the downloaded folder (i.e. the subject and the X and y files)
After that, using the rbind function I merge together the X and y train and test files and the subject files. 
Using cbind I then merge the result of these three previous merged data frames. 
Then, using the %>% command, I extracted the mean and standard deviation and added them to a resulting data table. 
In this data table, I named the activities using descriptive activity and then I appropriately labeled it with descriptive variable names. 
Finally, I created a Final tidy data set which was used to make the resulting data table.   
