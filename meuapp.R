# Carregando o pacote Shiny e Shinydashboard
library(shiny)
library(shinydashboard)
library(plotly)

# Carregando o dataset
covid_data <- read.csv("States.csv")

# Definindo o UI (interface do usuário)
ui <- dashboardPage(
  dashboardHeader(title = "COVID-19 nos EUA"),
  dashboardSidebar(
    # Menu suspenso para selecionar o estado
    selectInput("state", "Selecione um estado:",
                choices = unique(covid_data$state),
                selected = "New York"),
    # Intervalo de datas
    dateRangeInput("date_range", "Selecione o intervalo de datas:",
                   start = min(covid_data$date),
                   end = max(covid_data$date)),
    # Botões de rádio para selecionar o tipo de dado (casos ou mortes)
    radioButtons("data_type", "Selecione o tipo de dado:",
                 choices = c("Casos" = "cases", "Mortes" = "deaths"),
                 selected = "cases")
  ),
  dashboardBody(
    fluidRow(
      # Box para exibir o gráfico de linhas
      box(plotlyOutput("line_plot", height = 400)),
      # Box para exibir o histograma
      box(plotlyOutput("histogram_plot", height = 400)),
      # Box para exibir o boxplot
      box(plotOutput("boxplot", height = 400)),
      # Box para exibir a tabela com título em negrito, fonte maior e mais espaço
      box(title = div(style = "font-size: 20px; margin: 15px;",
                      "Resumo dos Dados"),
          tableOutput("summary_table"))
    )
  )
)

# Definindo o server
server <- function(input, output) {
  output$line_plot <- renderPlotly({
    # Filtrando os dados pelo estado selecionado e intervalo de datas
    filtered_data <- covid_data[covid_data$state == input$state &
                                  as.Date(covid_data$date) >= input$date_range[1] &
                                  as.Date(covid_data$date) <= input$date_range[2], ]
    
    # Criando o gráfico de linhas com plotly
    plot_ly(x = as.Date(filtered_data$date), y = filtered_data[[input$data_type]],
            type = "scatter", mode = "lines", line = list(color = "blue"),
            text = paste("Data: ", as.Date(filtered_data$date), "<br>",
                         input$data_type, ": ", filtered_data[[input$data_type]]),
            hoverinfo = "text") %>%
      layout(xaxis = list(title = "Data"), yaxis = list(title = input$data_type),
             title = paste("Casos de COVID-19 em", input$state))
  })
  
  output$histogram_plot <- renderPlotly({
    # Filtrando os dados pelo estado selecionado e intervalo de datas
    filtered_data <- covid_data[covid_data$state == input$state &
                                  as.Date(covid_data$date) >= input$date_range[1] &
                                  as.Date(covid_data$date) <= input$date_range[2], ]
    # Criando o histograma com plotly
    plot_ly(x = filtered_data[[input$data_type]], type = "histogram") %>%
      layout(xaxis = list(title = input$data_type),
             yaxis = list(title = "Frequência"),
             title = paste("Histograma de", input$data_type, "de COVID-19 em", input$state))
  })
  
  output$boxplot <- renderPlot({
    # Filtrando os dados pelo estado selecionado e intervalo de datas
    filtered_data <- covid_data[covid_data$state == input$state &
                                  as.Date(covid_data$date) >= input$date_range[1] &
                                  as.Date(covid_data$date) <= input$date_range[2], ]
    # Criando o boxplot
    boxplot(filtered_data[[input$data_type]], col = "skyblue",
            main = paste("Boxplot de", input$data_type, "de COVID-19 em", input$state),
            width = 800, height = 100)  # Ajuste o valor de width e height conforme necessário
  })
  
  output$summary_table <- renderTable({
    # Filtrando os dados pelo estado selecionado e intervalo de datas
    filtered_data <- covid_data[covid_data$state == input$state &
                                  as.Date(covid_data$date) >= input$date_range[1] &
                                  as.Date(covid_data$date) <= input$date_range[2], ]
    
    # Calculando as estatísticas descritivas e arredondando para duas casas decimais
    summary_stats <- data.frame(Moda = as.character(which.max(table(filtered_data[[input$data_type]]))),
                                Média = round(mean(filtered_data[[input$data_type]]), 2),
                                Mediana = round(median(filtered_data[[input$data_type]]), 2),
                                Desvio_Padrão = round(sd(filtered_data[[input$data_type]]), 2),
                                Mínimo = round(min(filtered_data[[input$data_type]]), 2),
                                Máximo = round(max(filtered_data[[input$data_type]]), 2))
    
    # Criando a tabela
    data.frame(Estado = rep(input$state, 1),
               `Intervalo de Datas` = rep(paste(input$date_range[1], " - ", input$date_range[2]), 1),
               Resumo = c(paste("Moda:", summary_stats$Moda),
                          paste("Média:", summary_stats$Média),
                          paste("Mediana:", summary_stats$Mediana),
                          paste("Desvio Padrão:", summary_stats$Desvio_Padrão),
                          paste("Mínimo:", summary_stats$Mínimo),
                          paste("Máximo:", summary_stats$Máximo)))
  })
}

# Rodando a aplicação Shiny
shinyApp(ui = ui, server = server)
