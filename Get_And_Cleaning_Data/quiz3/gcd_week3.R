# subsetting - quick review
set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X

X[which(X$var2>8),]

sort(X$var1)

sort(X$var2)

# Ordering with plyr
library(plry)
arrange(X, var1)

# Adding row and columns
X$var4 <- rnorm(5)


#getting data from the web
if(!file.exists("./data")){dir.create(".data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restautantes.csv", method="curl")
restData <- read.csv("./data/restautantes.csv")
