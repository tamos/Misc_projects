# R Script to do exploratory analysis on canada political contributions data

library(readr)
contributions <- read_csv("~/Downloads/PoliticalFinance/od_cntrbtn_de_e.csv")

colnames(contributions) <- gsub(" ", "_", colnames(contributions))

contributions$Contributor_last_name <- as.factor(contributions$Contributor_last_name)

contributions <- contributions[,c("Contributor_last_name", "Contributor_Postal_code")]
contributions <- na.omit(contributions)

last_name_count <- data.frame(levels(contributions$Contributor_last_name))
rownames(last_name_count) <- levels(contributions$Contributor_last_name)

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

