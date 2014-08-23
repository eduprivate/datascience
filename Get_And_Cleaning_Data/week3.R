hid <- read.csv('getdata-data-ss06hid.csv')

str(hid)

# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products
agricultureLogical = (with(hid, ACR==3 & AGS==6))
str(agricultureLogical)
which(agricultureLogical)

## Question 2

# download the image
url1 = "http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

download.file(url1, destfile = "./data/jeff.jpg")
list.files("./data")

install.packages("jpeg")
library("jpeg")

# load the image
pic = readJPEG("jeff.jpg", native = "TRUE")

head(pic)
summary(pic)
str(pic)
quantile(pic, probs = c(30, 50, 80)/100)

## Question 3

url3 = "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url4 = "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url3, destfile = "./data/gdp.csv")
download.file(url4, destfile = "./data/education.csv")

gdp = read.csv("gdg.csv",skip=1)
edu = read.csv("education.csv")

labels(gdp)
labels(edu)

gdp
str(gdp[100,1])
str(edu)
table(gdp$X, gdp$Gross.domestic.product.2012)

str(edu$CountryCode)
attributes(edu$CountryCode)
y = levels(edu$CountryCode)

str(gdp$X)
attributes(gdp$X)
x = levels(gdp$X)

# how many codes match
table(gdp$X %in% edu$CountryCode)

library(plyr)

#rename columns
gdp$X.8 = NULL
gdp$X.7 = NULL
gdp$X.6 = NULL
gdp$X.2 = NULL
gdp = rename(gdp, c(X="CountryCode", "GDP"="Rank", X.3= "Description", X.4="GDP", X.5="Extra"))
str(gdp)

table(x %in% y)

# sort
gdp[with(gdp, order(GDP)), ]

x = gdp[1:193,]
y = subset(edu, CountryCode != " ")
x

str(x)
str(y)
table(y$CountryCode %in% x$CountryCode)
order.gdp <- order(gdp$GDP)
order.gdp
head(gdp$GDP[order.gdp])
gdp[gdp$Rank,]
labels(edu)
levels(edu$Income.Group)


x = with(edu, CountryCode[Income.Group == "High income: nonOECD"])
highIncOECD = with(edu, CountryCode[Income.Group == "High income: OECD"])
check = sapply(gdp$CountryCode, function(a) a %in% x)
check2 = sapply(gdp$CountryCode, function(a) a %in% highIncOECD)

check2
gdp$check = check
gdp$check2 = check2

y = with(gdp, Rank[check]) 
y = with(gdp, Rank[check2]) 

y
y = as.matrix(y)
y = as.numeric(y)

class(y[1:1])

#recode missing values
y[y==""] <- NA
str(y)

# exclude missing vals from analysis
mean(y, na.rm=TRUE) 

## Question 5
names(gdp)
names(edu)
gdp = rename(gdp, c("CountryCode"="CountryCode1"))

mergedData = merge(gdp, edu)
str(mergedData)

attributes(mergedData$Income.Group)
levels(gdp$Rank)
result = subset(mergedData, Income.Group == "Lower middle income") 
str(result)
table(result)
as.numeric(mergedData$Rank)
result$Rank
q()