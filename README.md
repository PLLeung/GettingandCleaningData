# The file run_analysis.R contains all the R codes to do the analysis with comments.
# Assuming all the data are in the working directory.

# The following code is to run the run_analysis.R and output the dataset.
# The code also write the data to a text file "subjxact_mean.txt"
# It can be read by using data<-read.table("subjxact_mean.txt",header=T)

source("run_analysis.R")	# execute run_analysis.R
# An R object data with 180 rows and 81 columns should be created at this point

data				# display data