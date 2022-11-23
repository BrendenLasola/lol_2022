library(dplyr)
library(tidyverse)
library(ggplot2)
library(shiny)
library(shinythemes)
library(ggthemes)

#Loading Dataset
lol_data <-  read.csv("2022_lol.csv") 

#Worlds 2022 Data
worlds <- lol_data %>% 
  filter(league =='WCS') %>%
  filter(patch == '12.18')

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
       subtitle = "How many times was each Champion banned at Worlds 2022") 

#Champion picks and count 
num_picked <- worlds %>%
  group_by(champion) %>%
  count %>%
  arrange(desc(n)) %>%
  na_if("") %>%
  na.omit
 
#top 10 picked + graph
top_10picked <- head(num_picked,10)
top_10pickgraph <- ggplot(top_10picked, aes(x = reorder(champion, -n), y = n)) +
  geom_bar(stat="identity", color='black',fill='gray') + 
  xlab('Champion') + 
  ylab('# Banned') +
  labs(title = "Most Picked at Worlds 2022",
       subtitle = "How many times was each Champion picked at Worlds 2022")
                     
#games played for each team}
games_played <- worlds %>%
  filter(position == 'team') %>%
  group_by(teamname) %>% 
  count %>%
  arrange(desc(n))

#list of unique players for each role
top <-worlds %>%
  filter(position == 'top') %>%
  select(playername)
top_laners <- unique(top)
jng <-worlds %>%
  filter(position == 'jng') %>%
  select(playername)
jungle<- unique(jng)
mid <-worlds %>%
  filter(position == 'mid') %>%
  select(playername)
mid_laners <- unique(mid ) 
adc <- worlds %>%
  filter(position == 'bot') %>%
  select(playername)
bot_laners <- unique(adc)
sup <- worlds %>%
  filter(position == 'sup') %>%
  select(playername)
supports <- unique(sup)

#champions
champions <- unique(worlds$champion)

#num unique champs at worlds 2022
unique_champs <- length(champions)

#champs in role
mid_champs <- worlds %>%
  filter(position == "mid") %>%
  select(playername,champion)
jng_champs <- worlds %>%
  filter(position == "jng") %>%
  select(playername,champion)
top_champs <- worlds %>%
  filter(position == "top") %>%
  select(playername,champion)
bot_champs <- worlds %>%
  filter(position == "bot") %>%
  select(playername,champion)
sup_champs <- worlds %>%
  filter(position == "sup") %>%
  select(playername,champion,position)

#unique champs
mid_champs <- unique(mid_champs$champion)
jng_champs <- unique(jng_champs$champion)
top_champs <- unique(top_champs$champion)
bot_champs <- unique(bot_champs$champion) 
sup_champs <- unique(sup_champs$champion) 

#Number of unique champs per role
unique_champs <-  worlds %>%
  filter(position != 'team') %>%
  group_by(position) %>% 
  summarise(n=n_distinct(champion)) 
#Graphg of unique_champs
uchamps_graph <- ggplot(unique_champs,aes(y = reorder(position, n), x = n)) +
  geom_bar(stat="identity", color='black',fill='gray') + 
  xlab('Unique Champs') + 
  ylab('Role') +
  labs(title = "Unique Champs picked per Role",
       subtitle = "Which role had the most champion diversity") 

#champs that were played in one or two more roles
more_champs <- worlds %>%
  filter(position != 'team') %>%
  group_by(champion) %>%
  summarise(n=n_distinct(position)) %>%
  filter(n > 1) %>%
  arrange(desc(n)) 
#graph of more_champs
mchamps_graph <- ggplot(more_champs,aes(y = reorder(champion, n), x = n)) +
  geom_bar(stat="identity", color='black',fill='gray') + 
  xlab('Unique Champs') + 
  ylab('Role') +
  labs(title = "Champions picked for Multiple Roles (More than 1)") 

#teams with highest champion diversity
distinct_teams <- worlds %>%
  filter(position != 'team') %>%
  group_by(teamname) %>%
  summarise(unique_champs=n_distinct(champion)) %>%
  arrange(desc(unique_champs)) 
#graph of distinct_teams
team_graph <- ggplot(distinct_teams,aes(y = reorder(teamname, unique_champs), x = unique_champs)) +
  geom_bar(stat="identity", color='black',fill='gray') + 
  xlab('Teams') + 
  ylab('Unique Champs') +
  labs(title = "Unique Champs picked per Team",
       subtitle = "Which team had the most unique champs?") 

#players with the highest champion diversity 
distinct_players <- worlds %>%
  filter(position != 'team') %>%
  group_by(playername) %>%
  summarise(unique_champs=n_distinct(champion)) %>%
  arrange(desc(unique_champs))
distinct_players <- head(distinct_players,50)
#graph of distinct_players
player_graph <- ggplot(distinct_players,aes(y = reorder(playername, unique_champs), x = unique_champs)) +
  geom_bar(stat="identity", color='black',fill='gray') + 
  xlab('Unique Champs') + 
  ylab('Player Name') +
  labs(title = "Top 50 Unique Champs per Player",
       subtitle = "Who has the most unique champs?") 

#num games each player played
num_playergames <- worlds %>%
  filter(position != 'team') %>%
  group_by(playername) %>%
  summarise(num_games=n_distinct(gameid)) %>%
  arrange(desc(num_games)) 
 
#num games each team played
num_teamgames <- worlds %>%
  filter(position == 'team') %>%
  group_by(teamname) %>%
  summarise(num_games=n_distinct(gameid)) %>%
  arrange(desc(num_games))

uchamps_team <- merge(distinct_teams,num_teamgames,by="teamname")

champion_scatter <- ggplot(uchamps_team ,aes(x = num_games, y = unique_champs)) +
  geom_point(size = 2, color='black',fill='gray') + 
  xlab('Unique Champs') + 
  ylab('Role') +
  labs(title = "Unique champions over games played per team",
       subtitle = "Does more games = more champs played") 

uchamps_players <- merge(distinct_players,num_playergames, by="playername")

player_scatter <- ggplot(uchamps_players ,aes(x = num_games, y = unique_champs)) +
  geom_point(size = 2, color='black',fill='gray') + 
  xlab('Unique Champs') + 
  ylab('Role') +
  labs(title = "Unique champions over games played per player",
       subtitle = "Does more games = more champs played") 
