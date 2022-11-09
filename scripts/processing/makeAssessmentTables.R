## Load packages
library(tidyverse)

## Create raw data
df <- 
  data.frame(
    person = c(rep("Doug", 4),
               rep("Sarah", 4),
               rep("Eric", 4),
               rep("Manjari", 4),
               rep("HyunAh", 4),
               rep("Susan", 4),
               rep("Nicole", 4),
               rep("Marielle", 4),
               rep("JP", 4),
               rep("Jess", 4),
               rep("Zack", 4),
               rep("Yoseli", 4)),
    yearsInLab = c(rep(6,4),
                   rep(3,4),
                   rep(4,4),
                   rep(0.5,4),
                   rep(1,4),
                   rep(1,4),
                   rep(4,4),
                   rep(4,4),
                   rep(1,4),
                   rep(1,4),
                   rep(0.2,4),
                   rep(5,4)),
    category = c(rep(c("Doer", "Thinker", "Influencer", "Connector"), 12)),
    selfScore = c(9, 8, 2, 3, 5,6,6,6,6,11,3,3,2,5,13,3,
                  4,7,9,3,6,6,2,9,4,12,3,4,8,11,1,4,1,2,9,11,
                  5,6,1,11,0,2,13,8,8,5,2,8),
    groupScore = c(6, 3, 0, 0,0,6,3,6,6,9,1,0,6,4,0,1,
                   0,8,2,3,1,5,1,6,3,8,0,4,7,3,1,1,0,1,9,8,
                   4,7,0,0,0,2,7,8,5,6,1,5)
  )

## Pivot to create self score table
selfScoreTable <- 
  pivot_wider(data=df,
              id_cols="person",
              names_from="category",
              values_from="selfScore")

## Pivot to create group score table
groupScoreTable <- 
  pivot_wider(data=df,
              id_cols="person",
              names_from="category",
              values_from="groupScore")

## Write out results
write_delim(x=df, file="tables/longFormScores.txt", delim="\t")
write_delim(x=df, file="tables/selfScoreTable.txt", delim="\t")
write_delim(x=df, file="tables/groupScoreTable.txt", delim="\t")


