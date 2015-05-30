# 1  $ year            : int  2014 2013       
# 2  $ affiliate_code  : Factor w/ 39 levels  
# 3  $ impact_area     : Factor w/ 4 levels   
# 4  $ prog_cat        : Factor w/ 16 levels  
# 5  $ prog_type       : Factor w/ 96 levels  
# 6  $ prog_dur        : Factor w/ 8 levels   
# 7  $ fs1             : Factor w/ 390 levels 
# 8  $ fs2             : Factor w/ 195 levels 
# 9  $  fs3             : Factor w/ 116 levels 
# 10 $ prog_nm         : Factor w/ 1316 levels
# 11 $ status          : Factor w/ 10 levels  
# 12 $ prog_num        : Factor w/ 808 levels 
# 13 $ target_vet      : Factor w/ 4 levels   
# 14 $ comments        : Factor w/ 387 levels 
# 15 $ indiv_served    : Factor w/ 720 levels 
# 16 $ change_direction: Factor w/ 7 levels   
# 17 $ change_reason   : Factor w/ 12 levels  
# 18 $ undip_indiv     : Factor w/ 6 levels   
# 19 $ hh_served       : Factor w/ 321 levels 
# 20 $ undup_hh        : Factor w/ 7 levels   
# 21 $ affprog         : chr                  





checkvalidity <- function(df, pt){
#        print("Checking Validity")
         
#         #capture output in a file
#         sink("output.log", append = FALSE, split=FALSE)
        
        #sort by type
        df <- df[ order( df$prog_type ),]

        if (pt=="NA") {
                cat(paste("\n\nChecking all types\n"))  
                } else {
                cat(paste("\n\nChecking ",pt,"\n"))
                df <- subset(df, df$prog_type==pt,)       
                }
        
        
        if (is.na(df[1,1])) { 
                print("NO ROWS!!!!!")
                return(NULL)
        }
        
        rows <- nrow(df)
        cat(paste("Number of rows: ",rows,"\n"))
        

        count2013 <- 0
        count2014 <- 0
        progs2013 <- 0
        progs2014 <- 0
        
        
        typeprev <- df[1,5]
        progprev <- df[1,10]
        cat(paste("\n\nType: ",typeprev,"\n"))
        for (i in 1:rows) {
                if (as.numeric(df[i,1])==2013) { 
                        #debug
                        #cat(paste("adding indiv served of",as.integer(df[i,15]),"\n"))
                        
                        count2013 <- count2013 + as.numeric(df[i,15])
                        progs2013 <- progs2013 + 1;
                } else {
                        if (as.numeric(df[i,1])==2014) { 
                                #debug
                                #cat(paste("adding indiv served of",df[i,15],"\n"))
                                
                                count2014 <- count2014 + as.numeric(df[i,15])
                                progs2014 <- progs2014 + 1
                         }
                }
                
                #cat(paste("row # ",i,":  "))
                if (typeprev==df[i,5]) {
                        #do nothing
                } else {
                         #new type
                         typeprev <- df[i,5]
                         cat(paste("\n\nType: ",typeprev,"\n"))                     
                }
                if (progprev==df[i,10]) {
                        #do nothing
                } else {
                        cat("\n")
                        progprev <- df[i,10]
                        
                    }
                cat(paste(i,":",df[i,1]," ",df[i,2]," ",df[i,3]," cat:",df[i,4]," name:",df[i,10]," ",df[i,12]," (",df[i,11],df[i,16],") Indiv Served: ", df[i,15],"\n"))
        }
        cat(paste("\nSummary - ",pt,"\n"))
        
        cat(paste("\nNumber of Programs:\n"))
        cat(paste("Programs active in 2013: ", progs2013,"\n"))
        cat(paste("Programs active in 2014: ", progs2014,"\n"))
        cat(paste("Overall change:", progs2014 - progs2013,"\n" ))
        
        cat(paste("\nIndividuals Served:\n"))
        cat(paste("Total Served in 2013: ", count2013,"\n"))
        cat(paste("Total Served in 2014: ", count2014,"\n"))
        cat(paste("Overall change:", count2014 - count2013,"\n" ))
        cat(paste("Percent change:", round((((count2014 - count2013)/count2013)*100),digits=1),"%\n"))
        
#         #close output file
#         sink()
}
        




checktypes <- function(df, validity=TRUE, changed=TRUE, pt="NA") {
        if (validity) {
                checkvalidity(df,pt)
                }       
        if (changed) {
                print("Checking Changed")
                }
}
        
                  
        
do <- function(type) {   
#         dfmain <- read.csv("ProgData1314.csv")
        dfmain <- read.csv("ProgData1314.csv", stringsAsFactors=FALSE)
        
 #       rows <- nrow(dfmain)
 #       print(paste("total number of rows is: ", rows,sep=""))
        
        # Create a variable that combines affiliate_code and Prog_num
        dfmain$affprog <- paste(dfmain$affiliate_code, dfmain$prog_num)   
        
        
        df2014 <- subset(dfmain, as.numeric(dfmain$year)==2014,)
        df2013 <- subset(dfmain, as.numeric(dfmain$year)==2013,)
        #checktypes(df2014,1,0)
        #checktypes(df2014,1,0,"Youth/Family Support and Educational")
        #checktypes(dfmain,1,0,"Youth/Family Support and Educational")
        #checktypes(dfmain,1,0,"Youth/Family Support and Educational")
 
#         dfcathom <- subset(dfmain, dfmain$prog_cat=="Homeless Services")
#         checktypes(dfcathom,1,0,"Emergency Shelter")
#  

#         checktypes(dfmain,1,0,"Adult Literacy and Education")
#         checktypes(dfmain,1,0,"Alternative School")


#        checktypes(dfmain,1,0,"Emergency Shelter")
#         checktypes(dfmain,1,0,"Adult Literacy and Education")   NO ROWS


#         ####To check a single category, use these lines
#         onecat <- "Homeless Services"
#         dfonecat <- subset(dfmain, dfmain$prog_cat==onecat,)
#         checktypes(dfonecat,1,0,type)

        ####To check a single affiliate, use these lines
        oneaff <- "WANW"
        dfoneaff <- subset(dfmain, dfmain$affiliate_code==oneaff,)
        checktypes(dfoneaff,1,0,type)


        ##Else use this one
#      checktypes(dfmain,1,0,type)

 
  
}

checkall <- function() {
        
#set program category
pcat <- "All"        
        
#capture output in a file
sink(NULL)   #in case it had been left open
sink(paste(pcat,".log", sep=""), append = FALSE, split=TRUE)
cat(paste("\nProgram Category: ",pcat,"\n\n"))


do("Adoption")
do("Adult Literacy and Education ")
do("Alternative School")
do("Assisted Living")
do("Awards ")
do("Cars Helping People")
do("Case Management")
do("Child and Family Supportive Services")
do("Child Care")
do("Child Care Resource and Referral")
do("Clothing")
do("Community Sanctions Center/Re-Entry")
do("Computer Center")
do("Crime Victims Assistance")
do("Day Program")
do("Day Reporting")
do("Delinquency Prevention")
do("Disabled Housing")
do("Disaster Assistance")
do("Dispute Resolution and Mediation")
do("Diversion")
do("Domestic Violence ")
do("Dress for Success")
do("Drop In Center")
do("Early Childhood Intervention")
do("Early Head Start")
do("Elderly Housing")
do("Electronic Monitoring")
do("Emergency Assistance")
do("Emergency Shelter")
do("Employment Counseling and Job Placement")
do("Eviction Prevention")
do("Faith Services")
do("Family Housing")
do("Family Preservation")
do("Food Bank or Pantry")
do("Food Preparation Services")
do("Foster Care")
do("Grandparents as Parents")
do("Head Start")
do("Health and Nutrition Education")
do("Health Promotion")
do("HIV Prevention Education")
do("HIV/AIDS Services")
do("Home Health Care")
do("Home Ownership")
do("Home Repair/Handyman")
do("Homemaker Services")
do("Housing Placement")
do("I Remember Mama")
do("In-Home Supports")
do("Independent Living")
do("Information and Referral")
do("Interpreting Services")
do("Juvenile Group Home")
do("Make A Difference Day")
do("Martin Luther King Day")
do("Meals ")
do("Meals, Food and Gifts")
do("Mental Health Counseling and Treatment")
do("Mentoring")
do("Mother/Infant Programs")
do("National Retiree Volunteer Coalition")
do("Nursing Home Care")
do("Offender HIV Services")
do("Offender/Family Support")
do("Outpatient Treatment")
do("Outreach")
do("Parent Education")
do("Pet Care ")
do("Pre- and After-School Care")
do("Pre-Trial")
do("Pregnancy Counseling")
do("Program Support")
do("Protective Services")
do("Random Acts of Kindness")
do("Residential Camp ")
do("Residential Care")
do("Residential Treatment")
do("Respite Services")
do("Restitution Program")
do("Scholastic Books ")
do("Senior Center")
do("Senior Service Corps")
do("Service Coordination in Affordable Housing")
do("Single Adult Housing")
do("Summer Camp")
do("Supported Employment")
do("Supported Living")
do("Supportive Housing")
do("Supportive Services")
do("Thrift and Retail Stores")
do("Training of Professionals")
do("Transitional Housing")
do("Transitional Shelter")
do("Transportation")
do("Volunteer Recruitment/Placement")
do("Work Experience Program")
do("Youth Development")
do("Youth Emergency Shelter/Group Home")
do("Youth/Family Support and Educational")


do("Community Corrections/Re-Entry")
do("Correctional Diversion Program")
do("Day Program for Elderly and/or Disabled ")
do("Emergency Assistance for Veterans")
do("Employment Counseling and Job Placement for Homeless Veterans (HVRP)")
do("Food & Clothing")
do("PACE")
do("Select from List")
do("Service Center for Veterans")
do("Supportive Housing for Veterans")
do("Supportive Services for Veterans & Veterans' Families ")
do("Tax Preparation")
do("Transitional Housing for Veterans (GPD & Per Diem)")
do("Veterans")

#close output file
sink(NULL)     
}


# TO DO:

#         Feed it a dataframe subsetted on category

#         Read type master into a dataframe that contains type and and a character vector of acceptible categories
#         send the vector into the check routine as well.
        