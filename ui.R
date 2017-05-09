################Loading packages###################

library("shiny")
library("shinythemes")

####################################################

Data<-read.csv("WCHRI_researchers_clinical_trials_in_dataverse.csv")
researchers<-read.csv("WCHRI_researchers.csv")


##############Setting up user interface with title and Sidebar ##############
#if (interactive()) 
#{

shinyUI(fluidPage(theme=shinytheme("darkly"),
		titlePanel(h2 ("Women and Child Health Research Institute (WCHRI) Metadata Catalogue", align="left",
				   img(src = "uamyaccount.png", height = 100, width = 300, align='right'))
			      ),
		sidebarLayout(position= 'left',
    			sidebarPanel(

####### Creating dynamic drop down list with researcher's name ########

selectInput("data1", 
        	label = h4("Select one"),
        	choices = c(names(researchers))
	       ),

uiOutput("res"),

br(),
helpText("Following dropdown menus are dynamically linked to the selection in 
	   above drop down menu"),
uiOutput("CT_ids"),

helpText("Following dropdown menu is dynamically linked to the selection in 
	   first drop down menu"),
uiOutput("web"),
uiOutput("link"),
#a(href = "https://clinicaltrials.gov/ct2/show/record/#Output$CT_ids", target="_blank",
#actionButton("open", "Go to selected resource!!")),

br(),
br(),
	  
#########Creating Download action button##########
helpText(h4("Download Metadata from Clinicaltrial.gov for multiple IDs")),
 fileInput("file1", "Upload CSV File with NCT IDs",
        accept = c(
          "text/csv",
          "text/comma-separated-values,text/plain",
          ".csv")
        ),

	downloadButton("Go!!", "Download Metadata!!"),
br(),
br(),

######## Creating hyperlinks in the sidebar ##########

#tags$div(class="header", checked=NA,
#tags$p(h4("Useful links")),
#tags$a(href="http://redcap.ualberta.ca/", "Redcap"),
#br(),
#tags$a(href="http://clinicaltrials.gov/", "clinicaltrials.gov"),
#br(),
#tags$a(href="http://dataverse.org/", "Dataverse"),
#br(),
#tags$a(href="http://www.ncbi.nlm.nih.gov/pubmed/", "NCBI PubMed"),
#br(),
#tags$a(href="http://www.wchri.org/", "WCHRI")

# 	  ),

######################################################
	align='left'
	),
########## Side bar ends on upper line ###############
 
########## Main panel designing with 3 tabs ###########		   
   
mainPanel(	
	tabsetPanel(
   	  		tabPanel("Home", textOutput("home")),
               	tabPanel("Study level metadata", textOutput("concise_m")), 
        		tabPanel("Complete metadata Schema", tableOutput("redcap"))
			),

	tableOutput("contents")
	
		    
		    	  )
  		)
	)
)

#}



###########################################################################

######code to open a new window by clicking "About Catalogue" button#######

#fluidRow(
#     uiOutput("newWindowContent", style = "display: none;"),
#     tags$script(HTML("
#      $(document).ready(function() {
#         if(window.location.hash != '') {
#           $('div:not(#newWindowContent)').hide();
#           $('#newWindowContent').show();
#           $('#newWindowContent').appendTo('body');
#         }
#       })
#    ")),
#    a(href = "#aboutcatalogue", target = "_blank",
#       actionButton("About", "About Catalogue")
#     )
#   ),

##########################################################################		
#br(),   		
#br(),

########################################################

#### Consider changing these outputs to some other may be table for study level metadata#######		
#			htmlOutput(
#					"html"
#			    	    ), 
#
#			textOutput(
#				"text2"
#				    ), 
#
#
#			textOutput(
#				"text3"
#			    	    ),
######This chunk of code can be used for some other useful purpose ########		



