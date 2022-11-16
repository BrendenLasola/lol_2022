library(dplyr)
library(tidyverse)
library(ggplot2)
library(shiny)
library(shinythemes)
library(ggthemes)

#Loading Dataset
lol_data <-  read.csv("Data/2022_lol.csv") 

#data specifically looking at worlds 2022
worlds <- lol_data %>% 
  filter(league =='WCS') %>%
  filter(patch == '12.18')

#Q: Create a dataset that has worlds_team, who they picked and who they banned.
#Notes:  1. Maybe remove the side from the actual columns
#        2. How do I get the champion picks on tho this dataset

#All the games on blue side
blue_side <- worlds %>%
  filter(position == 'team') %>%
  filter(side == 'Blue') %>%
  select(gameid,teamname,side,ban1,ban2,ban3,ban4,ban5) %>%
  rename(blue_team = teamname,
         blue = side,
         b1 = ban1,
         b2 = ban2,
         b3 = ban3,
         b4 = ban4, 
         b5 = ban5)

#blue side top 
blue_top <- worlds %>%
  filter(position == 'top') %>%
  filter(side == 'Blue') %>%
  select(gameid,champion) %>%
  rename(blue_top = champion)

#blue side jung
blue_jng <- worlds %>%
  filter(position == 'jng') %>%
  filter(side == 'Blue') %>%
  select(gameid,champion) %>%
  rename(blue_jng = champion)

#blue side mid
blue_mid <- worlds %>%
  filter(position == 'mid') %>%
  filter(side == 'Blue') %>%
  select(gameid,champion) %>%
  rename(blue_mid = champion)

#blue side bot
blue_bot <- worlds %>% 
  filter(position == 'bot') %>%
  filter(side == 'Blue') %>%
  select(gameid, champion) %>%
  rename(blue_bot = champion)

#blue side sup
blue_sup <- worlds %>%
  filter(position == 'sup') %>%
  filter(side == 'Blue') %>%
  select(gameid,champion) %>%
  rename(blue_sup = champion)

#list of all roles for blue side with team
blue_list <- list(blue_side,blue_top,blue_jng,blue_mid,blue_bot,blue_sup)

#blue team, merging all picks and bans
blue_team <- blue_list %>%
  reduce(full_join, by ='gameid')

#deleting blue column because it isn't needed anymore. 
blue_team$blue <- NULL

#All games on red side      
red_side <- worlds %>%
  filter(position == 'team') %>%
  filter(side == 'Red') %>%
  select(gameid,teamname,side,ban1,ban2,ban3,ban4,ban5) %>%
  rename(red_team = teamname,
         red = side,
         r1 = ban1,
         r2 = ban2,
         r3 = ban3,
         r4 = ban4, 
         r5 = ban5)

#red side top 
red_top <- worlds %>%
  filter(position == 'top') %>%
  filter(side == 'Red') %>%
  select(gameid,champion) %>%
  rename(red_top = champion)

#red side jung
red_jng <- worlds %>%
  filter(position == 'jng') %>%
  filter(side == 'Red') %>%
  select(gameid,champion) %>%
  rename(red_jng = champion)

#redside mid
red_mid <- worlds %>%
  filter(position == 'mid') %>%
  filter(side == 'Red') %>%
  select(gameid,champion) %>%
  rename(red_mid = champion)

#blue side bot
red_bot <- worlds %>% 
  filter(position == 'bot') %>%
  filter(side == 'Red') %>%
  select(gameid, champion) %>%
  rename(red_bot = champion)

#red side sup
red_sup <- worlds %>%
  filter(position == 'sup') %>%
  filter(side == 'Red') %>%
  select(gameid,champion) %>%
  rename(red_sup = champion)

#list of all roles for red side with team
red_list <- list(red_side,red_top,red_jng,red_mid,red_bot,red_sup)

#blue team, merging all picks and bans
red_team <- red_list %>%
  reduce(full_join, by ='gameid')

#deleting red column because it isn't needed anymore. 
red_team$red <- NULL

#Merging blue team and red team by gameid
worlds_team <- merge(blue_team,red_team,by="gameid")

#Champion picks and count 
num_picked <- worlds %>%
  group_by(champion) %>%
  count %>%
  arrange(desc(n)) %>%
  na_if("") %>%
  na.omit

#combining all the bans together
bans <- worlds %>%
  filter(position == 'team') %>%
  select(ban1,ban2,ban3,ban4,ban5) 

#wide to long conversion of bans 
bans <- pivot_longer(bans, cols=1:5, names_to = 'ban', values_to = 'banned')

#only banned
bans <- bans %>% select(banned)

#champions banned and count
num_banned <- bans %>%
  group_by(banned) %>%
  count %>%
  arrange(desc(n))

#top 10 banned
top_10bans <- head(num_banned,10)
top_10bangraph <- ggplot(top_10bans, aes(x = reorder(banned, -n), y = n)) +
  geom_bar(stat="identity", color='black',fill='gray') + 
  xlab('Champion') + 
  ylab('# Banned') +
  labs(title = "Most Banned at Worlds 2022",
       subtitle = "How many times was each Champion banned at Worlds 2022") +
  theme_fivethirtyeight() 

#top 10 picked
top_10picked <- head(num_picked,10)
top_10pickgraph <- ggplot(top_10picked, aes(x = reorder(champion, -n), y = n)) +
  geom_bar(stat="identity", color='black',fill='gray') + 
  xlab('Champion') + 
  ylab('# Banned') +
  labs(title = "Most Picked at Worlds 2022",
       subtitle = "How many times was each Champion picked at Worlds 2022") +
  theme_fivethirtyeight() 
                     
                     
#games played for each team}
games_played <- worlds %>%
  filter(position == 'team') %>%
  group_by(teamname) %>% 
  count %>%
  arrange(desc(n))

#adc and champs
adc <- worlds %>%
  filter(position == 'bot') %>%
  select(playername,champion) %>%
  group_by(playername,champion) %>%
  summarise(total_count=n(),.groups = 'drop') %>%
  arrange(desc(total_count))

#support and champs
sup <- worlds %>%
  filter(position == 'sup') %>%
  select(playername,champion) %>%
  group_by(playername,champion) %>%
  summarise(total_count=n(),.groups = 'drop') %>%
  arrange(desc(total_count))

#mid laners and champs
mid <- worlds %>%
  filter(position == 'mid') %>%
  select(playername,champion) %>%
  group_by(playername,champion) %>%
  summarise(total_count=n(),.groups = 'drop') %>%
  arrange(desc(total_count))

#jung and champs
jung <- worlds %>%
  filter(position == 'jng') %>%
  select(playername,champion) %>%
  group_by(playername,champion) %>%
  summarise(total_count=n(),.groups = 'drop') %>%
  arrange(desc(total_count))

#top laners and champs
top <- worlds %>%
  filter(position == 'top') %>%
  select(playername,champion) %>%
  group_by(playername,champion) %>%
  summarise(total_count=n(),.groups = 'drop') %>%
  arrange(desc(total_count))

#Function that shows what each player was playing and how many times they played that champion
num_bot <- function(name) {
  num_played <- adc %>%
    filter(playername == name)
  return(num_played)
}
num_mid <- function(name) {
  num_played <- mid %>%
    filter(playername == name)
  return(num_played)
}
num_sup <- function(name) {
  num_played <- sup %>%
    filter(playername == name)
  return(num_played)
}
num_jung <- function(name) {
  num_played <- jung %>%
    filter(playername == name)
  return(num_played)
}
num_top <- function(name) {
  num_played <- top %>%
    filter(playername == name)
  return(num_played)
}

#Playernames
bot_laners <- unique(adc$playername)
support   <- unique(sup$playername)
top_laners <- unique(top$playername)
mid_laners <- unique(mid$playername)
jungle     <- unique(jung$playername)

#Split the dataset into: Play-In's, Group Stages, Knockout Stage, Quarter Final, Semi Final, Final 



