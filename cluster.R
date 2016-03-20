setwd("C://Users//Cássio//Dropbox//mias-analysis")

load("wass-dists.RData")

scsv = read.csv("C://Users//Cássio//datasets//all-mias//supervisao.csv")
sup = as.numeric(scsv$classeSev)

d = as.dist(D)

h = hclust(d, method = 'single')

#plot(h)

mem = cutree(h, k = 2)

# adj. rand index:
require(mclust)

adjustedRandIndex(mem, sup)
classError(mem, sup)

