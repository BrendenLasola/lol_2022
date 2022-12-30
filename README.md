# League of Legends Data Analysis: What affects Champion Diversity at the highest level? 

## Basic rundown of League of Legends E-Sports

League of Legends is a MOBA (Multiplayer Online Battle Arena), a 5 v 5 action game that has players picking certain characters known as champions. Each player takes on one of 5 different roles: Top Lane, Jungle, Mid Lane, Attack Damage Carry, and Support. There are over 162 champions in League of Legends and each champion is made for one of these 5 roles, some champions can be played in many different roles, but most are tailored to one role. Without going into detail about the whole game and how it works, the main purpose of this project is to see if having a diverse champion pool makes a good team. Is the ability to use multiple different champions something professional teams strive for? 

The Worlds 2022 dataset is provided by [oracleselixir.com](http://oracleselixir.com). They have a csv file that has all of 2022 league of legends e-sports. Worlds is the biggest in league of legends e-sports. According to escharts.com, Worlds 2022 had a peak of 5.1 million concurrent viewers across different streaming platforms and languages.

## Technical Goals

This exploratory data analysis is done with R to improve skills in:

1. Data wrangling with dplyr
2. Data visualization with ggplot2 
3. Creating interactive web apps with shinyapp

## Main Questions

The purpose of this project is to see what the benefits are to having a diverse champion pool.

1. What champions at Worlds 2022 were used in multiple different roles?
2. What roles have the most champion diversity at Worlds 2022? 
3. Which teams had the most champion diversity at Worlds 2022? 
4. Which players had the most champion diversity at Worlds 2022? 
5. What are the biggest factors that affect Champion Diversity?


## Champion Diversity Web App
[Unique Champions Player Data](https://yunghiro.shinyapps.io/lol_2022/)

Throughout my time working on the dataset one of the things that I was always looking at was how many unique champs did x player have. There were over x number of players at worlds across x number of teams. I initially made a chart, but it was tiresome to scour the chart for specific players and their data. My solution was to create an interactive webapp that shows you all the champions each player has picked and how many times they picked each champion throughout their tournament run.

## Champions Played in different Roles

![mchamps_graph](https://user-images.githubusercontent.com/77668770/203864916-c895b93c-39b1-4191-9e16-1878bbba488c.png)

### Only 2 characters were picked in 3 different roles which are:
 1. Seraphine (ADC, MID, SUP)
 2. Maokai (TOP, JNG, SUP)
 
### The rest were only picked in two different roles:
1. Yone (MID, TOP)
2. Syndra (MID/TOP)
3. Shen (SUP/TOP)
4. Sejuani (TOP, JNG)
5. Lillia (TOP, JNG)
6. Ashe (ADC, JNG)

### Main Takeaways:
* Top Lane and Support had the most champions that were used in multiple different roles. Support with 6 and Top Lane with 5. 
* Mid Lane, Jungle, and ADC had the least amount of champions played in multiple roles with 3 each. 
* The most common pairings of roles that shared champions were ADC/SUP with champions like Seraphine, Senna, and Ashe being played in both roles and TOP/JNG with champions such as Maokai, Sejuani, and Lillia sharing both roles. 

## Roles that had the greatest Champion Diversity

![uchamps_graph](https://user-images.githubusercontent.com/77668770/203864931-809ce33f-b1d5-469f-9671-8ddc6a38ef67.png)

NOTE: ADC, Mid and Jungle have the least diversity out of the 5 roles and TOP/Support having the most diverse roles. 

## Teams that had the greatest Champion Diversity

![team_graph](https://user-images.githubusercontent.com/77668770/203864922-4bd0a1a5-96cb-4b52-8aee-999cf22004e2.png)

## Players that had the greatest Champion DIversity

![player_graph](https://user-images.githubusercontent.com/77668770/203864918-6954b758-18f9-4810-9a74-876cc9b304bd.png)

NOTE: Top 4 players are all play in the support role 

## What affects Champion Diversity in League of Legends

### How the players role affects Champion Diversity
Looking at the graphs, what affects champion diversity the most is the number games played, role of the player, and the meta. The role of the player has a greater affect to champion diversity compared to games played. The graphs showed that support and top lane had the most champions played in multiple roles and had the most champion diversity in the tournament. 4 out of the 5 players with the most champion diversity in the whole tournament were support players. Support also had the greatest champion diversity out of all the roles. 

### How the Meta affects Champion Diversity 
Due to the nature of the game, roles such as Jungle and ADC have always had less champion diversity than other roles because of the fact that these roles need hyperspecific archetypes to play that role. Other roles such as mid lane, top lane, and support have multiple character archetypes for that role. The biggest surprise is the fact that mid had about the same unique champs picked as jungle. This leads in to the the overall meta game of League of Legends. Compared to other sports, e-sports have balance patches and updates, this means that depending on the update some champions are stronger than the other. An example in sports would be how certain rule changes affect how the overall game is being played. THe NBA has been very strict at toning down the overall physicality of the game and because of that more people are shooting threes. In League of Legends, this same instance occurs but dictates what characters are strong and weak. 

![top_10picks](https://user-images.githubusercontent.com/77668770/203871203-294a2d14-431b-4f00-9108-a095f2c54f92.png)

4 out of the top 10 most picked characters in the game were all played in the mid lane: Sylas, Azir, Akali, and Viktor. This means that most teams were not going outside the strong champions in the mid lane. The meta for this game relied on having stable champions on the mid lane which led to less champion diversity. 

### How number of games played affects Champion Diversity
![champion_scatter](https://user-images.githubusercontent.com/77668770/203866193-a7f1c6b8-d1f5-41d2-bac2-1a977af5c345.png)

Number of games in theory should have the highest factor on the affects of champion diversity but it only manifests in team champion diversity compared to player champion diversity. The number of games played has a high correlation with champion diversity because it takes into account more players. Looking at this graph it shows that there is a very high correlation between number of games and unique champs but looking at the graph below the correlation is lower.

![player_scatter](https://user-images.githubusercontent.com/77668770/203866205-af14aff1-9a87-430d-b230-e9df3272e339.png)

Looking at this graph it shows that the overall correlation of unique champs and games played is a lot lower for player data. A lot of players had similar values meaning they played the same amount of games and used the same amount of champs. There is an overall correlation between number of games played and unique champs but not doesn't greatly affects a players champion diversity compared to previous mentioned. 

