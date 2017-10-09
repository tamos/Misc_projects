install.packages("NLP")

tweets <- read.csv("F:/Work/Datasets/clinton-trump-tweets/tweets.csv")

originals <- subset(tweets, tweets$original_author=="")

originals <- tweets[tweets$original_author=="",]

rtweets <- tweets[!(tweets$original_author==""),]

tweets <- originals
rm(rtweets)
rm(originals)

write.csv(tweets, "F:/Work/Datasets/clinton-trump-tweets/tweets2.csv")

install.packages("NLP")

library(NLP)
library(stringi)

candidates <- c("HillaryClinton","realDonaldTrump") 

for (i in 1:2)
  {
  tweets <- read.csv("F:/Work/Datasets/clinton-trump-tweets/tweets2.csv")
  tweets <- tweets[(tweets$handle == candidates[i]), ]
 
  tokened <- unlist(strsplit(as.character(tweets$text), split = " ")) 

compound <- grep("([:;'?!&*()_+.#])\\b", tokened, value = TRUE)

punctuation <- gsub("[^:;'?!&*()_+.#]", "", compound)   

depunctd <- gsub("[:;'?!&*()_+.#]", "", compound) 
rm(compound)

tokened[grep("([:;'?!&*()_+.#])\\b", tokened)] <- depunctd
rm(depunctd)

tokened <- append(tokened, punctuation, length(tokened))
rm(punctuation) 

write(tokened, stri_c("tokens", candidates[i], ".txt"), append = TRUE)  
rm(tokened) 
} 

rm(tweets)
rm(candidates)
rm(i)




# s <- "The quick brown fox jumps over the lazy dog"
# ## Split into words:
# w <- strsplit(s, " ", fixed = TRUE)[[1L]]
# ## Word tri-grams:
# 
# tweetsdon <- readLines("tokensrealDonaldTrump.txt")
# tweetshil <- readLines("tokensHillaryClinton.txt")
# table(ngrams(tweetsdon, 1L))

install.packages("RKEA", repos=c("http://rstudio.org/_packages", "http://cran.rstudio.com"), dependencies = TRUE)
library(RKEA)

tweetsdon <- readLines("tokensrealDonaldTrump.txt")
tweetshil <- readLines("tokensHillaryClinton.txt")

mod <- createModel(tweetsdon)
  
)






hilgrams <- ngrams(tweetshil, 2L)
dongrams <- ngrams(tweetsdon, 2L)
rm(tweetshil)
rm(tweetsdon)


d <- t(data.frame(hilgrams))
d <- data.frame(d)
d[,3] <- "Hill"
colnames(d) <- c("gram1", "gram2", "name")

e <- t(data.frame(dongrams))
e<- data.frame(e)
e[,3] <- "Don"
colnames(e) <- c("gram1", "gram2", "name")

rm(dongrams)
rm(hilgrams)

d <- rbind(d, e)

d[,3] <- as.factor(d[,3])

rm(e)


classifier <- naiveBayes(d[,1:2], d[,3])
summary(predict(classifier, d[,1:2]), d[,3])
table(predict(classifier, d[,1:2]), d[,3])



# bigrams <- data.frame(unlist(hilgrams))
# bigrams[,2] <- "Hill"
# colnames(bigrams) <- c("gram", "name")
# bigrams <- rbind(bigrams, unlist(dongrams))
# bigrams[!(bigrams$name == "Hill"),2] <- "Don" 
# bigrams[,2] <- as.factor(bigrams[,2])


classifier <- naiveBayes(onegrams[,1], onegrams[,2])
table(predict(classifier, onegrams[,1]), onegrams[,2])


# tweetsdon




  tweets <- read.csv("F:/Work/Datasets/clinton-trump-tweets/tweets2.csv")
  tweets <- tweets[(tweets$handle == c("HillaryClinton")), ]
  
  tokened <- unlist(strsplit(as.character(tweets$text), split = " ")) 
  
  punctuation <- gsub("[^:;'?!&*()_+.,#-]", " ", tokened)  

  punctuation <- grep("[:;'?!&*()_+.,#-]", punctuation, value = TRUE)
  punctuation <- unlist(strsplit(punctuation, split = " "))
  punctuationhil  <- grep("[:;'?!&*()_+.,#-]", punctuation, value = TRUE)
  

  tweets <- read.csv("F:/Work/Datasets/clinton-trump-tweets/tweets2.csv")
  tweets <- tweets[(tweets$handle == c("realDonaldTrump")), ]
  
  tokened <- unlist(strsplit(as.character(tweets$text), split = " ")) 
  
  punctuation <- gsub("[^:;'?!&*()_+.,#-]", " ", tokened)  
  
  punctuation <- grep("[:;'?!&*()_+.,#-]", punctuation, value = TRUE)
  punctuation <- unlist(strsplit(punctuation, split = " "))
  punctuationdon  <- grep("[:;'?!&*()_+.,#-]", punctuation, value = TRUE)
  
  table(punctuation)
  
  punctuationdon <- data.frame(punctuationdon)
  punctuationdon[,2] <- "Donald"
  colnames(punctuationdon) <- c("punct", "candidate")
  
  punctuationhil <- data.frame(punctuationhil)
  punctuationhil[,2] <- "Hillary"
  colnames(punctuationhil) <- colnames(punctuationdon)
  
  punctuation <- rbind(punctuationdon, punctuationhil)
 punctuation[,2] <- as.factor(punctuation[,2])
 
 
  
  install.packages('e1071', dependencies = TRUE)
  library(e1071)
  library(class)
  
  classifier <- naiveBayes(punctuation[,1], punctuation[,2])
  table(predict(classifier, punctuation[,1]), punctuation[,2])
  
  