#!/usr/bin/Rscript

args <- commandArgs(TRUE)
Qfile <- args[1]
famfile <- args[2]
outname <- args[3]

Q <- read.table(Qfile)
fam <- read.table(famfile)[1]
Q$pop <- fam$V1

P <- aggregate(Q[,1:(ncol(Q)-1)],list(Q$pop),mean)
row.names(P) <- paste0(row.names(P),":")
P$num <- table(Q$pop)

write.table(P[,2:ncol(P)],file=outname,quote=F,sep="\t",row.names=T,col.names=F,append=T)
