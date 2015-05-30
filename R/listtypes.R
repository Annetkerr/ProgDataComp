listtypes <- function() {

        
dftypes <- read.csv("typemaster.csv")
rows <- nrow(dftypes)
print(paste("total number of rows is: ", rows,sep=""))

#capture output in a file
sink(NULL)
sink("typelist.txt", append = FALSE, split=TRUE)


#sort by type
dftypes <- dftypes[ order( dftypes$type),]

typeprev <- dftypes[1,3]
       


cat(paste("\n\n***",dftypes[1,3],"***  \n"))
for (i in 1:rows) { 
        if (typeprev==dftypes[i,3]) {
                #just print the category
                cat(paste(dftypes[i,2],",  "))
        } else {
                #print the type and the category  
                cat(paste("\n\n***",dftypes[i,3],"***  \n")) 
                cat(paste(dftypes[i,2],",  "))
                
                #set typeprev to the new one
                typeprev <- dftypes[i,3]
                
         }

        
}


#close output file
sink(NULL)
}