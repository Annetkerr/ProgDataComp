# checktypes <- function() {


dftypes <- read.csv("typemaster.csv")
rows <- nrow(dftypes)
print(paste("total number of rows is: ", rows,sep=""))

#sort by type
dftypes <- dftypes[ order( dftypes$type),]

tprev <- dftypes$type
for (i in 1:rows) {
        
        
}



# }