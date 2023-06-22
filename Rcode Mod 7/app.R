library(dash)
library(dashCoreComponents)

app <- dash_app()

df <- read.csv("C:\\Users\\lacey\\Desktop\\Utica College Stuff\\DSC 611\\Module Seven\\Life Expectancy Data.csv", 
               stringsAsFactors = FALSE,
               check.names = FALSE)

continents <- unique(df$Continent)
years <- unique(df$Year)

app %>% set_layout(
  dccGraph(id = 'graph-with-slider'),
  dccSlider(
    id = 'year-slider',
    min = 0,
    max = length(years) - 1,
    marks = years,
    value = 0
  )
)

app %>% add_callback(
  output(id = 'graph-with-slider', property = 'figure'),
  input(id = 'year-slider', property = 'value'),
  function(selected_year_index) {
    
    which_year_is_selected <- which(df$Year == years[selected_year_index + 1])
    
    traces <- lapply(
      continents, function(cont) {
        which_continent_is_selected <- which(df$Continent == cont)
        
        df_sub <- df[intersect(which_year_is_selected, which_continent_is_selected), ]
        
        list(
          x = df_sub$GDP,
          y = df_sub$Life_expectancy,
          opacity = 0.5,
          text = df_sub$Country,
          mode = 'markers',
          marker = list(
            size = 15,
            line = list(width = 0.5, color = 'white')
          ),
          name = cont
        )
      }
    )
    
    figure <- list(
      data = traces,
      layout = list(
        xaxis = list(type = 'log', title = 'GDP Per Capita'),
        yaxis = list(title = 'Life Expectancy', range = c(20,90)),
        margin = list(l = 40, b = 40, t = 10, r = 10),
        legend = list(x = 0, y = 1),
        hovermode = 'closest'
      )
    )
    
    figure
  }
)

app %>% run_app()