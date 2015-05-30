do <- function() {
        df <- read.csv("cat.csv")
        rows <- nrow(df)
        print(paste("total number of rows is: ", rows))
#         year2014 <- subset(df, as.numeric(df$year)==2014,)
#         year2013 <- subset(df, as.numeric(df$year)==2013,)
#         year2012 <- subset(df, as.numeric(df$year)==2012,)
#         year2011 <- subset(df, as.numeric(df$year)==2011,)
#         year2010 <- subset(df, as.numeric(df$year)==2010,)
#         year2009 <- subset(df, as.numeric(df$year)==2009,)
#         
# 
#         print(year2009)
#         print(year2010)
#         print(year2011)
#         print(year2012)
#         print(year2013)
#         print(year2014)
#        
        #subset on catnum

        cat_chlyth <- subset(df, df$catname=="Children and Youth",)


        cat_chlyth <- subset(df, as.numeric(df$catnum)==1,)
        cat_comenh <- subset(df, as.numeric(df$catnum)==2,)
        cat_corSvc <- subset(df, as.numeric(df$catnum)==3,)
        cat_dissvc <- subset(df, as.numeric(df$catnum)==4,)
        cat_eldsvc <- subset(df, as.numeric(df$catnum)==5,)
        cat_emrsvc <- subset(df, as.numeric(df$catnum)==6,)
        cat_emptrn <- subset(df, as.numeric(df$catnum)==7,)
        cat_hcprev <- subset(df, as.numeric(df$catnum)==8,)
        cat_homsvc <- subset(df, as.numeric(df$catnum)==9,)
        cat_housfs <- subset(df, as.numeric(df$catnum)==10,)
        cat_housde <- subset(df, as.numeric(df$catnum)==11,)
        cat_subabu <- subset(df, as.numeric(df$catnum)==13,)
        cat_notdef <- subset(df, as.numeric(df$catnum)==99,)

        


        
#         for (i in 1:rows) {
#                 
#           print(df[i,1])
#           print(df[i,2])
#           print(df[i,3])
#         }
}

do()