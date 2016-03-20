require(TDA)

set.seed(1234)

basedir = "C://Users//Cássio//Dropbox//mias-analysis"

setwd(basedir)

outdir = file.path(basedir, "topologies")

datadir = "C://Users//Cássio//datasets//all-mias//region-data"

csvfiles = list.files(datadir)
basenames = gsub(".csv", "", csvfiles)

maxdimension = 1 # max d of simplices: 0 connected comp; 1 loops; 2 voids...

i = 1
for (f in csvfiles) {
  cat(date(), "-- Processing file", f, "\n")
  P = as.matrix(read.table(file.path(datadir, f), header = F, sep = ','))
  
  MAXP = 100 # maximum number of points
  
  if(nrow(P) > MAXP) {
    
    x = 1:nrow(P)
    idxs = sample(x, size = MAXP, replace = FALSE)
    Ps = P[idxs,]
    
  } else {
    
    Ps = P
    
  }
  
  D = dist(Ps)
  maxscale = max(D)  #summary(D)[2] # 1st qu.
  
  Diag = ripsDiag(Ps, maxdimension = maxdimension, maxscale = maxscale, library = "Dionysus")$diagram
  save(Diag, file = file.path(outdir, paste(basenames[i], "-topo.RData", sep = '')))
  i = i + 1
  
}
