# Instala y carga las librerías necesarias
install.packages("plotly")
library(plotly)

# Simulación de datos de precios de activos financieros
set.seed(123)
n_days <- 100
n_assets <- 5

dates <- seq(from = Sys.Date() - n_days + 1, to = Sys.Date(), by = "days")
asset_names <- c('GWW','ES','HSY','MCK','NVR')
returns <- matrix(rnorm(n_days * n_assets, mean = 0, sd = 0.02), ncol = n_assets)
prices <- apply(returns, 2, cumsum) + rep(1:5, each = n_days)

# Crea una matriz de volatilidades móviles
rolling_window <- 20
volatility <- apply(returns, 2, function(x) rollapply(x, width = rolling_window, FUN = sd, fill = NA))

# Crea un gráfico interactivo de volatilidad
plot <- plot_ly(x = dates, type = "scatter", mode = "lines", name = asset_names[1], y = volatility[, 1],
                line = list(color = "blue")) %>%
  add_trace(y = volatility[, 2], line = list(color = "red"), name = asset_names[2]) %>%
  add_trace(y = volatility[, 3], line = list(color = "green"), name = asset_names[3]) %>%
  add_trace(y = volatility[, 4], line = list(color = "purple"), name = asset_names[4]) %>%
  add_trace(y = volatility[, 5], line = list(color = "orange"), name = asset_names[5]) %>%
  layout(title = "Volatilidad de activos financieros",
         xaxis = list(title = "Fecha"),
         yaxis = list(title = "Volatilidad"),
         showlegend = TRUE)

# Muestra el gráfico
plot
