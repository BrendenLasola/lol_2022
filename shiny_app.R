source("GitHub/lol_2022/analysis.R")

ban_page <- tabPanel(
  "MOST BANNED",
  sidebarPanel(
        p("Througout Worlds 2022, there were three champions that had significantly more bans than other teams. 
          What this means is that most teams in the tournament consider these three champions as problem characters.
          Yuumi has a 100% win rate, Caitlyn had 62.5% win rate, and Aatrox had a 54.5% win rate (Win rate was not provided
          in this data set, data was collected from gol.gg). Yuumi and Caitlyn were picked 8 times while Aatrox was picked 22 times. This data shows that even though Aatrox 
          was deemed as a strong Champion more teams were willing to let him go compared to Caitlyn and Yuumi."), 
          
          p("Bans in League of Legends is interesting because after the first 3, the other bans are spread out. In specific patches or 
          versions of the game, some characters are deemed to be too strong. This is what decides the overall metagame of league
          of legends. The rest of the banning phase are more spread out because teams are banning specific champions against specific teams.
          "),
  ),
    ### Main panel displays the bar graph
    mainPanel(
      plotOutput(outputId = "most_banned")
    )
  )

pick_page <- tabPanel(
  "MOST PICKED",
  sidebarPanel(
       p ("Compared to bans, the champion diversity in picks are a lot more spreadout. The way that pick and bans work in league of Legends is")
  ),
  ### Main panel displays the bar graph
  mainPanel(
    plotOutput(outputId = "most_picked"),
  )
)

top_page <- tabPanel(
  "TOP",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "top_id",
        label = "Top Laners",
        choices = top_laners,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      plotOutput(outputId = "top_data"),
    )
  )
)

bot_page <- tabPanel(
  "ADC",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "bot_id",
        label = "AD Carrys",
        choices = bot_laners,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      plotOutput(outputId = "bot_data"),
    )
  )
)

mid_page <- tabPanel(
  "MID",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "mid_id",
        label = "Mid Laners",
        choices = mid_laners,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      plotOutput(outputId = "mid_data"),
    )
  )
)

sup_page <- tabPanel(
  "SUP",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "sup_id",
        label = "Supports",
        choices = support,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      plotOutput(outputId = "sup_data"),
    )
  )
)

jun_page <- tabPanel(
  "JNG",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "jun_id",
        label = "Junglers",
        choices = jungle,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      plotOutput(outputId = "jun_data"),
    )
  )
)


#creating the plot
server <- function(input,output) {
  
  output$most_banned<- renderPlot({
    top_10bangraph
  })
  
  output$most_picked<- renderPlot({
    top_10pickgraph
  })
  
  output$top_data <- renderPlot({
    
    top <- worlds %>%
      filter(position == 'top') %>%
      filter(playername == input$top_id) %>%
      select(playername,champion) %>%
      group_by(playername,champion) %>%
      summarise(total_count=n(),.groups = 'drop') %>%
      arrange(desc(total_count))
    
    top_graph <- 
      ggplot(top, aes(x = reorder(champion, -total_count), y = total_count)) +
      geom_bar(stat="identity", color='black',fill='gray') +
      xlab('Champion') +
      ylab('# Picked') +
      labs(title = "Champion Diversity",
           subtitle = "How many times did they pick X character?") +
      theme_fivethirtyeight() + 
      scale_y_continuous(breaks=c(0,2,4,6,8,10))
    
    top_graph
  })
  
  output$bot_data <- renderPlot({
    
    bot <- worlds %>%
      filter(position == 'bot') %>%
      filter(playername == input$bot_id) %>%
      select(playername,champion) %>%
      group_by(playername,champion) %>%
      summarise(total_count=n(),.groups = 'drop') %>%
      arrange(desc(total_count))
    
    bot_graph <- 
      ggplot(bot, aes(x = reorder(champion, -total_count), y = total_count)) +
      geom_bar(stat="identity", color='black',fill='gray') +
      xlab('Champion') +
      ylab('# Picked') +
      labs(title = "Champion Diversity",
           subtitle = "How many times did they pick X character?") +
      theme_fivethirtyeight() + 
      scale_y_continuous(breaks=c(0,2,4,6,8,10))
    
    bot_graph
  })
  
  output$sup_data <- renderPlot({
    
    sup <- worlds %>%
      filter(position == 'sup') %>%
      filter(playername == input$sup_id) %>%
      select(playername,champion) %>%
      group_by(playername,champion) %>%
      summarise(total_count=n(),.groups = 'drop') %>%
      arrange(desc(total_count))
    
    sup_graph <- 
      ggplot(sup, aes(x = reorder(champion, -total_count), y = total_count)) +
      geom_bar(stat="identity", color='black',fill='gray') +
      xlab('Champion') +
      ylab('# Picked') +
      labs(title = "Champion Diversity",
           subtitle = "How many times did they pick X character?") +
      theme_fivethirtyeight() + 
      scale_y_continuous(breaks=c(0,2,4,6,8,10))
    
    sup_graph
  })
  
  output$mid_data <- renderPlot({
    
    mid <- worlds %>%
      filter(position == 'mid') %>%
      filter(playername == input$mid_id) %>%
      select(playername,champion) %>%
      group_by(playername,champion) %>%
      summarise(total_count=n(),.groups = 'drop') %>%
      arrange(desc(total_count))
    
    mid_graph <- 
      ggplot(mid, aes(x = reorder(champion, -total_count), y = total_count)) +
      geom_bar(stat="identity", color='black',fill='gray') +
      xlab('Champion') +
      ylab('# Picked') +
      labs(title = "Champion Diversity",
           subtitle = "How many times did they pick X character?") +
      theme_fivethirtyeight() + 
      scale_y_continuous(breaks=c(0,2,4,6,8,10))
    
    mid_graph
  })
  
  output$jun_data <- renderPlot({
    
    jun <- worlds %>%
      filter(position == 'jng') %>%
      filter(playername == input$jun_id) %>%
      select(playername,champion) %>%
      group_by(playername,champion) %>%
      summarise(total_count=n(),.groups = 'drop') %>%
      arrange(desc(total_count))
    
    jun_graph <- ggplot(jun, aes(x = reorder(champion, -total_count), y = total_count)) +
      geom_bar(stat="identity", color='black',fill='gray') +
      xlab('Champion') +
      ylab('# Picked') +
      labs(title = "Champion Diversity",
           subtitle = "How many times did they pick X character?") +
      theme_fivethirtyeight() + 
      scale_y_continuous(breaks=c(0,2,4,6,8,10))
    
    jun_graph
  })
}

ui <- fluidPage(theme = shinytheme('cosmo'),
  navbarPage("WORLDS 2022 CHAMPION DIVERSITY",
  ban_page,pick_page,top_page,jun_page,mid_page,bot_page,sup_page))

# Run the application 
shinyApp(  ui, server = server)