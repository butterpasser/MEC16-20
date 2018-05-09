library(tidyverse)
library(ggplot2)
library(reshape2)

gradify <- function(a){ return(unlist(strsplit(a,split="_",fixed=TRUE)[2])) }

s1<-read.csv("S1.csv",stringsAsFactors = FALSE)
s2<-read.csv("S2.csv",stringsAsFactors = FALSE) 
s3<-read.csv("S3.csv",stringsAsFactors = FALSE)
supply<- read.csv("supply.csv",stringsAsFactors = TRUE)
supply <-subset(supply,Reg_no !='\f')
courseNames <- read.csv("course_code.csv")
s1 <- melt(s1 , id.vars ="Reg_no")
s1$Sem <-'S1'
s2 <- melt(s2 , id.vars ="Reg_no")
s2$Sem <-'S2'
s3 <- melt(s3 , id.vars ="Reg_no")
s3$Sem <-'S3'
b <- supply %>%gather(key,value,-Reg_no)
b<- subset(b,value!="")
supply <- b
supply$sem <- 'Supply.'
names(supply)<-c('Reg_no','variable','value','Sem')
#barplot(table(subset(result,Reg_no == 'MDL16CS053')$Grade),xlab="Grade",ylab="Frequency",main="Grade Chart for MDL16CS053")
result <- rbind(s1,s2)
result <- rbind(result,s3)

a <- lapply(result$value,str_replace,pattern = '\\(',replacement = '_')
a <- lapply(a,str_replace,pattern = '\\)',replacement = '')
a<-str_split_fixed(a,"_",2)
b <- lapply(supply$value,str_replace,pattern = '\\(',replacement = '_')
b <- lapply(b,str_replace,pattern = '\\)',replacement = '')
b <- str_split_fixed(b,'_',2)

result$variable <- a[,1]
result$value <- a[,2]
supply$variable <- b[,1]
supply$value <- b[,2]
names(supply) <- c('Reg_no','Subject','Grade','Exam')
names(result) <- c('Reg_no','Subject','Grade','Exam')
result2 <- subset(result,Exam =='S3')
result <- subset(result,Exam !='S3')
result <- subset(result,Grade !='F')
result <- subset(result,Grade !='FE')
result <- subset(result,Grade !='Absent')
result <-rbind(result,supply)
result <- rbind(result,result2)
