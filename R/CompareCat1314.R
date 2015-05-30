compare <- function(catnm, affcd="na", yr="na") {
        #subset on the selected category
        dfcat <- subset(df, df$prog_cat==catnm,)
        
        #sort by affiliate_code, Prog_nm, year
        tempsort <- dfcat[order( dfcat$affiliate_code, dfcat$prog_nm, dfcat$year),]
        
        #if an affiliate_code was selected, subset on that.
        if (affcd=="na") {
                print("No affiliate code specified")
            } else { 
                    print(paste("affiliate code: ", affcd, sep="")) 
                    dfsub <- subset(dfcat, df$affiliate_code==affcd )
            }
      

        
        
        
        
        #subset on the years witin the cateogry
        dfcyear2014 <- subset(dfcat, as.numeric(dfcat$year)==2014,)
        dfcyear2013 <- subset(dfcat, as.numeric(dfcat$year)==2013,)
        
        #count and display the number of programs in the category for each year
        rows2014 <- nrow(dfcyear2014)
        rows2013 <- nrow(dfcyear2013)
        print(paste("Comparing ",catnm,", ",rows2014," programs in 2014, and ",rows2013," programs in 2013", sep=""))
        
        
        for (i in 1:rows2014) {
                if (as.character(dfcyear2014[i,5])=="Food Bank or Pantry") {
#                 print(paste(i))
#                 print(paste(dfcyear2014[i,1],
#                             dfcyear2014[1,2],
#                             dfcyear2014[1,3],
#                             dfcyear2014[1,4],
#                             dfcyear2014[1,5],
#                             dfcyear2014[1,6],
#                             dfcyear2014[1,7],
#                             dfcyear2014[1,8],
#                             dfcyear2014[1,9],
#                             dfcyear2014[1,10],
#                             dfcyear2014[1,11],
#                             dfcyear2014[1,12],
#                             dfcyear2014[1,13],
#                             dfcyear2014[1,14]                         
#                             ))
                
                

                        print(paste(dfcyear2014$affiliate_code,
                                dfcyear2014$prog_nm,
                                "(",
                                dfcyear2014$indiv_served,
                                ")",
                                dfcyear2014$change_direction,
                                dfcyear2014$hh_served,
                                dfcyear2014$status))

                }
                else {
                        print(dfcyear2014[i,5])
                }
                }
}

Validate_types <- function(catnm="na", affcd="na", yr="na") {
        
        
}
        
        
        
comparecats <- function() {
        df <- read.csv("ProgData1314.csv")
        rows <- nrow(df)
        print(paste("total number of rows is: ", rows,sep=""))
  
        # Create a variable that combines affiliate_code and Prog_num
        df$affprog <- paste(df$affiliate_code, df$prog_num)   
        
        
        year2014 <- subset(df, as.numeric(df$year)==2014,)
        year2013 <- subset(df, as.numeric(df$year)==2013,)
         
        chlyth <- c("Children and Youth")
        comenh <- c("Community Enhancement")
        corsvc <- c("Correctional Services")
        dissvc <- c("Disabilities Services")
        eldsvc <- c("Elderly Services")
        emrsvc <- c("Emergency Services")
        emptrn <- c("Employment and Training Services")
        hcprev <- c("Health Care Prevention")
        hlthcr <- c("Health Care Services")
        homsvc <- c("Homeless Services")
        housfs <- c("Housing for Families and Single Adults")
        housde <- c("Housing for the Disabled and Elderly")
        mntlhl <- c("Mental Health")
        subabu <- c("Substance Abuse")
        notdef <- c("Select from List")
                         
        
        
        dfchlyth <- subset(df, df$prog_cat==chlyth,)
        dfcomenh <- subset(df, df$prog_cat==comenh,)
        dfcorsvc <- subset(df, df$prog_cat==corsvc,)
        dfdissvc <- subset(df, df$prog_cat==dissvc,)
        dfeldsvc <- subset(df, df$prog_cat==eldsvc,)
        dfemrsvc <- subset(df, df$prog_cat==emrsvc,)
        dfemptrn <- subset(df, df$prog_cat==emptrn,)
        dfhcprev <- subset(df, df$prog_cat==hcprev,)
        dfhlthcr <- subset(df, df$prog_cat==hlthcr,)
        dfhomsvc <- subset(df, df$prog_cat==homsvc,)
        dfhousfs <- subset(df, df$prog_cat==housfs,)
        dfhousde <- subset(df, df$prog_cat==housde,)
        dfmntlhl <- subset(df, df$prog_cat==mntlhl,)
        dfsubabu <- subset(df, df$prog_cat==subabu,)
        dfnotdef <- subset(df, df$prog_cat==notdef,)    
        
        rows_chlyth  <- nrow(dfchlyth) 
        rows_comenh  <- nrow(dfcomenh)
        rows_corsvc  <- nrow(dfcorsvc)
        rows_dissvc  <- nrow(dfdissvc)
        rows_eldsvc  <- nrow(dfeldsvc)
        rows_emrsvc  <- nrow(dfemrsvc)
        rows_emptrn  <- nrow(dfemptrn)
        rows_hcprev  <- nrow(dfhcprev)
        rows_hlthcr  <- nrow(dfhlthcr)
        rows_homsvc  <- nrow(dfhomsvc)
        rows_housfs  <- nrow(dfhousfs)
        rows_housde  <- nrow(dfhousde) 
        rows_mntlhl  <- nrow(dfmntlhl)
        rows_subabu  <- nrow(dfsubabu)
        rows_notdef  <- nrow(dfnotdef)   
        
        rowcheck <- 
                rows_chlyth +
                rows_comenh +
                rows_corsvc +
                rows_dissvc +
                rows_eldsvc +
                rows_emrsvc +
                rows_emptrn +
                rows_hcprev +
                rows_hlthcr +
                rows_homsvc +
                rows_housfs +
                rows_housde +
                rows_mntlhl +
                rows_subabu +
                rows_notdef
         
        print(paste("total number of rows in separate dataframes is: ", rowcheck))
       
        
        
}

#comparecats()
# compare(chlyth)
# compare(comenh)
# compare(corsvc)
# compare(dissvc)
# compare(eldsvc)
#compare(emrsvc, "WANW")
# compare(emptrn)
# compare(hcprev)
# compare(hlthcr)
# compare(homsvc)
# compare(housfs)
# compare(housde)
# compare(mntlhl)
# compare(subabu)
# compare(notdef)
