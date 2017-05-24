##### Script for searching for all the WCHRI researchers' driven  #####
##### clinical trials through clinicaltrials.gov API and to download #####
##### all the information related to that clinical trials  ######

# This script will first count if there is any clinical trial for the WCHRI members 
# listed in the imported csv file. Then, it converts and downloads several 
# dataframes into the form of csv files.

ClinTrialMetadataDownload<- function(file_path) 
{
  if (!requireNamespace("rclinicaltrials", quietly = TRUE)) 
	{
    	stop("Pkg needed for this function to work. Please install it.",
      call. = FALSE)
  	}
  else if(!requireNamespace("plyr", quietly = TRUE))
	{
	stop("Pkg needed for this function to work. Please install it.",
      call. = FALSE)
  	}


  library(rclinicaltrials)
  library(plyr)
  df<-read.csv(file =file_path )
  l_df <- dim(df)[1]
  for(i in 1:l_df) 
	{ 
		z<- toString(df[i,1])    
      	x<-clinicaltrials_count(query= z)

		if (x > 0)
	 	{
 	   		y<-clinicaltrials_download(query=z, include_results=FALSE, include_textblocks=TRUE)
			n<-length(y)
			lapply(1:n, function(i) write.csv(y[[i]], file = paste(names(y[i]), z, ".csv", sep = "."),row.names = FALSE))
	   		
	 	}
		
 	}
	
}
