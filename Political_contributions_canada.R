# R Script to do exploratory analysis on canada political contributions data

library(readr)
contributions <- read_csv("~/Downloads/PoliticalFinance/od_cntrbtn_de_e.csv")

colnames(contributions) <- gsub(" ", "_", colnames(contributions))

contributions$Contributor_last_name <- as.factor(contributions$Contributor_last_name)
#contributions$Contributor_last <- as.factor(contributions$Contributor_last_name)

contributions <- contributions[,c("Contributor_last_name", "Contributor_Postal_code", "Electoral_event")]
contributions <- na.omit(contributions)

last_name_count <- data.frame(levels(contributions$Contributor_last_name))
rownames(last_name_count) <- levels(contributions$Contributor_last_name)

lastnames <- as.numeric(length(contributions$Contributor_last_name))
lastnames_unique <- as.numeric(nlevels(contributions$Contributor_last_name))

contributions[,4] <- paste(contributions$Contributor_last_name, contributions$Contributor_Postal_code, contributions$Electoral_event)
contributions$V4 <- as.factor(contributions$V4)
unique_wpostcode_welection <- as.numeric(nlevels(contributions$V4))



aggregate(contributions$V4, by = contributions$v4, count)

g <- table(head(contributions$V4))


counted_totals <- data.frame()
for (i in length(contributions$V4)){
  count <- 0
  if (contributions$V4[i] == contributions$V4[i]) {
    count <- count+1
    contributions$V4 <- "Counted"
  }
  counted_totals <- rbind(count)
}








# draft implementation with for loop
for (potential_last_name in contributions$Contributor_last_name){
  for (actual_last_name in contributions$Contributor_last_name){
    count <- 0
    if (actual_last_name == potential_last_name) { 
      if(contributions[])
     count <- count + 1
    last_name_count[potential_last_name,] <- count
    }
  }
}

