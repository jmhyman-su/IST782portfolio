url <- ("https://basketball.realgm.com/ncaa/stats/2021/Averages/Qualified/All/Season/All/points/desc/1/")



library(rvest)
webpage <- read_html(url)
webpage %>% html_table() -> tables
tables[[1]] -> tables

library(tidyverse)
total_stats <- tibble()
for (i in 2010:2021){
  for(j in 1:10){
    url <- paste("https://basketball.realgm.com/ncaa/stats/",i,"/Averages/Qualified/All/Season/All/points/desc/",j,"/", sep = "")
    print(url)
    webpage <- read_html(url)
    webpage %>% html_table() -> tables
    tables[[1]] -> tables
    tables$season <- i
    total_stats %>% bind_rows(tables) -> total_stats
  }
}


write.csv(total_stats, "total_player_stats.csv")
