listTypesInFile <- function() {

df <- read.csv("ProgData1314.csv", stringsAsFactors=FALSE)
rows <- nrow(df)
print(paste("total number of rows is: ", rows,sep=""))
#sort by type
df <- df[ order( df$prog_type ),]


typeprev <- df[1,5]

#capture output in a file
sink(NULL)
sink("typesInFile.txt", append = FALSE, split=TRUE)

cat(paste("\n\n***",df[1,5],"***  \n"))
for (i in 1:rows) { 
        if (typeprev==df[i,5]) {
#                 #just print the category
#                 cat(paste(dftypes[i,2],",  "))
        } else {
                #print the type and the category  
                cat(paste(df[i,5],"\n")) 
#                 cat(paste(dftypes[i,2],",  "))
                
                #set typeprev to the new one
                typeprev <- df[i,5]
                
        }
        
        
}
#close output file
sink(NULL)
}