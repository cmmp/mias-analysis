require(TDA)

indir = "C://Users//Cássio//Dropbox//mias-analysis//topologies//"

setwd("C://Users//Cássio//Dropbox//mias-analysis//")

files = list.files(indir)
basenames = gsub("-topo.RData", "", files)

N = length(files)

D = matrix(0, nrow = N, ncol = N)

L = list()

for (i in 1:N) {
  f = files[i]
  load(file.path(indir, f))
  L[[i]] = list(name = basenames[i], diag = Diag)
}

dimension = 1 # which dimension to use for wasserstein comparisons.

cat("Beginning dist calculations at", date(), "\n")
 for (i in 1:(N-1)) {
   for (j in (i+1):N) {
     wd = wasserstein(L[[i]]$diag, L[[j]]$diag, dimension = dimension)
     D[i,j] = wd
     D[j,i] = wd
   }
 }
cat("Finished dist calculations at", date(), "\n")

save(L, D, file = "wass-dists.RData")


