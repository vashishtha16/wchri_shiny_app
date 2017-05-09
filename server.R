library(shiny)
researchers<-data.frame(read.csv("WCHRI_researchers.csv"))
studies<-data.frame(read.csv("WCHRI_researchers_clinical_trials_in_dataverse.csv"))
webresource<-data.frame(read.csv("web_resources.csv"))
studylink<-data.frame(read.csv("study_links.csv"))
redcap_metadata<-data.frame(read.csv("REDCap_metadata.csv"))
if (interactive()) 
{
 	shinyServer(
	function(input, output) 
	{
		var1<-reactive({
		   				switch(input$data1,
							  "Researchers.with.clinical.trials"= researchers[ ,1],
						  	  "Researchers.with.cohort.studies"= researchers [ ,2],
						  	  "Researchers.with.clinical.trial.and.cohort.studies"=researchers[ ,3]
			    		  	  )
				  	  })
				  
		output$res<-renderUI({
							  selectInput("res", h4("Select a researcher"), choices=var1())
							})				
		
	var2<-reactive({
					if(is.null(input$res))						
						return('None')		  
		  			switch(input$res,     
			   				"Adatia, Ian" = studies[ ,1], "Ali, Samina" = studies[ ,2], "Amirav, Israel" = studies [ ,3],"Ball, Geoff" = studies[ 4],
			   				"Castro Codesal, Maria" = studies[ ,5], "Craig, William"= studies[ ,6], "Curtis, Sarah"= studies[ ,7], 
			   				"Dixon, Andrew"= studies[ ,8], "Freedman, Stephen"=studies[ ,9], "Gowrishankar, Manjula" = studies[ ,10],
			   				"Haqq, Andrea" = studies[ ,11], "Hartling, Lisa" = studies[ ,12], "Hawkes, Michael" = studies[ ,13], 
			   				"Huang, Vivian"= studies[ ,14],"Letourneau, Nicole"= studies[ ,15],"Mackie, Andrew"= studies[ ,16], 
			   				"MacLean, Joanna"= studies[ ,17],"Mager, Diana"= studies[ ,18], 
			   				"Newton, Amanda"= studies[ ,19], "Parent, Eric"= studies[ ,20],"Richer, Lawrence"= studies[ ,21],
			   				"Robinson, Joan"= studies[ ,22], "Ross, Sue"= studies[ ,23],"Ryerson, Lindsay"= studies[ ,24],
			   				"Tough, Suzanne"= studies[ ,25], "Vohra, Sunita"= studies[ ,26], "West, Lori"= studies[ ,27],
			   				"Wiart, Lesley"= studies[ ,28]		 
			     		 )	 

		      		})
	output$CT_ids<-renderUI({
							selectInput("CT", h4("Brief study title"), choices=var2())
					   	   })
	
	
	var3<-reactive({
			switch(input$data1,
					"Researchers.with.clinical.trials"= webresource[ ,1],
					"Researchers.with.cohort.studies"= webresource[ ,2],
					"Researchers.with.clinical.trial.and.cohort.studies"= webresource[ ,3]
				  )
				 })								
	output$web<-renderUI({
						selectInput("WEB", h4("Select metadata webresource"), choices=var3())
						})							   																	
	
	
	var4 <-reactive({
					i<-match(input$CT, as.character(studylink[ ,1]))
#					print(i)
						if(is.null(input$WEB))
						return('None')
      					switch(input$WEB,
						"clinicaltrials.gov" = as.character(studylink[i,2]),
						"dataverse.org"= as.character(studylink[i,3])
			 			  )
			 		})		 			  	   				
    output$link<-renderUI({	
						weblink<-as.character(var4())
		 				a(href=paste(weblink),actionButton("open", "Go to selected resource!!"))
		   				 })					  
	var5 <-reactive({
					j<-match(input$CT, as.character(redcap_metadata[ ,4]))
					if(is.null(input$WEB))						
						return('None')
						switch(input$WEB,
						"RedCap"=  redcap_metadata[j, ]
							  )
				    })
	output$redcap<-renderTable({
								var5()
						  
						    })				    
						
						


# output$newWindowContent <- renderUI({
#										h1("About Catalogue")		
#	   			   					 })

#### Dowload Button ###
output$contents <- renderTable({
			# input$file1 will be NULL initially. After the user selects
 				# and uploads a file, it will be a data frame with 'name',
 				# 'size', 'type', and 'datapath' columns. The 'datapath'
 				# column will contain the local filenames where the data can
 				# be found.
    		
			inFile <- input$file1
 				if (is.null(inFile))
			return(NULL)
			read.csv(inFile$datapath)
			downloadcontent<-ClinTrialMetadataDownload(inFile$datapath)
  				})

output$downloadData<-downloadHandler(
									 inFile <- input$file1,
									 contents
  										 )
  ## MAIN PANEL CONTENT ###
   output$home <- renderText({
   							"The University of Alberta Libraries worked with members of the Women and Child Health Research Institute (WCHRI) to develop this study catalog. The project is focused on 	describing research studies and the data associated with them in order to help make maternal and child health research discoverable and accessible to the broader research community. The project goals are to highlight the work of WCHRI members, better enable researchers to connect with potential collaborators, and improve research by minimizing duplication of effort by allowing others to know about and build upon existing data (if permitted).
				 			A selected group of researchers participated in this pilot project, amounting to nearly forty studies. These studies represent a range of research, both completed and ongoing. Most of the studies are randomized controlled trials and cohort studies, but there is also, for example, a systematic review and mixed-methods qualitative studies.
				 			study catalog collects in one place a pool of metadata for each study. Some of this metadata was derived from already publicly available sources, such as ClinicalTrials.gov, and some was gathered from close reading of study documentation and discussion with researchers."			 
			    			})
   output$concise_m <- renderText({
    							"This should open a page with study level metadata."
			         			 })
#   output$complete <- renderText({
#   							"This should open a page with complete metadata."
#			          			})		   
			   }
	)
}

# Not in use currently
############################################################################################	
#	   output$html <- renderUI({ 
#			  paste("Counting of clicks on About Catalogue button is :-",input$html)
#   					})
#  
#   output$text2 <- renderText({ 
#			  paste("Selected researcher:- ",input$var)
#    					 })
#
#
#    output$text3 <- renderText({ 
#			  paste(" Type of metadata schema:-",input$radio)
#    					 }) 	
#############################################################################################
