top_page <- tabPanel(
  "TOP",
  sidebarLayout(
    sidebarPanel(
      h3(""),
      selectInput(
        inputId = "top_id",
        label = "Top Laners",
        choices = top_laners,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      h3(""),
      plotOutput(outputId = "top_data"),
      p("")
    )
  )
)

bot_page <- tabPanel(
  "ADC",
  sidebarLayout(
    sidebarPanel(
      h3(""),
      selectInput(
        inputId = "bot_id",
        label = "AD Carrys",
        choices = bot_laners,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      h3(""),
      plotOutput(outputId = "bot_data"),
      p("")
    )
  )
)

mid_page <- tabPanel(
  "MID",
  sidebarLayout(
    sidebarPanel(
      h3(""),
      selectInput(
        inputId = "mid_id",
        label = "Mid Laners",
        choices = mid_laners,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      h3(""),
      plotOutput(outputId = "mid_data"),
      p("")
    )
  )
)

sup_page <- tabPanel(
  "SUP",
  sidebarLayout(
    sidebarPanel(
      h3(""),
      selectInput(
        inputId = "sup_id",
        label = "Supports",
        choices = support,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      h3(""),
      plotOutput(outputId = "sup_data"),
      p("")
    )
  )
)

jun_page <- tabPanel(
  "JNG",
  sidebarLayout(
    sidebarPanel(
      h3(""),
      selectInput(
        inputId = "jun_id",
        label = "Junglers",
        choices = jungle,
      ),
    ),
    ### Main panel displays the bar graph
    mainPanel(
      h3(""),
      plotOutput(outputId = "jun_data"),
      p("")
    )
  )
)


#creating the plot
server <- function(input,output) {
  
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
      geom_bar(stat="identity", color='skyblue',fill='steelblue') +
      xlab('Champion') +
      ylab('# Picked')
    
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
      geom_bar(stat="identity", color='skyblue',fill='steelblue') +
      xlab('Champion') +
      ylab('# Picked')
    
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
      geom_bar(stat="identity", color='skyblue',fill='steelblue') +
      xlab('Champion') +
      ylab('# Picked')
    
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
      geom_bar(stat="identity", color='skyblue',fill='steelblue') +
      xlab('Champion') +
      ylab('# Picked')
    
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
      geom_bar(stat="identity", color='skyblue',fill='steelblue') +
      xlab('Champion') +
      ylab('# Picked')
    
    jun_graph
  })
}

ui <- navbarPage(
  "Data Analysis",
  top_page,jun_page,mid_page,bot_page,sup_page
)

# Run the application 
shinyApp(ui = ui, server = server)

