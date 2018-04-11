library(tidyverse)
library(ggplot2)
library(reshape2)

gradify <- function(a){ return(unlist(strsplit(a,split="_",fixed=TRUE)[2])) }

s1<-read.csv("S1.csv",stringsAsFactors = FALSE)
s2<-read.csv("S2.csv",stringsAsFactors = FALSE) 
s3<-read.csv("S3.csv",stringsAsFactors = FALSE)
courseNames <- read.csv("course_code.csv")
totalResult <- merge(s1,s2)
totalResult <- merge(totalResult,s3)
#barplot(table(subset(result,Reg_no == 'MDL16CS053')$Grade),xlab="Grade",ylab="Frequency",main="Grade Chart for MDL16CS053")
result <- melt(totalResult,id.vars = "Reg_no")
a <- lapply(result$value,str_replace,pattern = '\\(',replacement = '_')
a <- lapply(a,str_replace,pattern = '\\)',replacement = '')
a<-str_split_fixed(a,"_",2)
result$variable <- a[,1]
result$value <- a[,2]

names(result) <- c('Reg_no','Subject','Grade')
MA101 <- data.frame(table(totalResult$Subject1))
Grade <- c('A','A+','Absent','B','B+','C','F','O')
names(MA101) <- c("Grade","Frequency")
MA101$Grade <- Grade

#pie(MA101$Frequency,MA101$Grade,main="Calculus result of S1 for year 2016-17")
MA1012 <- data.frame(table(totalResult$Subject17))
Grade <- c('A','A+','B','B+','C','F','O','P')
names(MA1012) <- c("Grade","Frequency")

MA1012$Grade <- Grade
MA201 <- data.frame(table(totalResult$Subject19))
names(MA201) <- c('Grade','Frequency')
MA201$Grade <- c('A','A+','Absent','B','B+','C','F','FE','O','P')