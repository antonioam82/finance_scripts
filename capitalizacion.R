# Instalar y cargar la librería necesaria
#install.packages("quantmod")
library(quantmod)

# Definir el símbolo de la acción y el rango de fechas
ticker <- "NVDA"  # Símbolo de Apple Inc. (puedes cambiarlo por el de otra acción)
start_date <- "2020-01-01"
end_date <- Sys.Date()  # Fecha actual

# Obtener los datos históricos de la acción
getSymbols(ticker, from = start_date, to = end_date)

# Calcular la capitalización de mercado (precio de cierre * número de acciones en circulación)
market_cap <- Cl(get(ticker)) * Vo(get(ticker))
tail(market_cap)

# Graficar la evolución de la capitalización de mercado
plot(index(market_cap), market_cap, type = "l", col = "blue",
     main = paste("Evolución de la Capitalización de Mercado de", ticker),
     xlab = "Fecha", ylab = "Capitalización de Mercado (en USD)")

# Agregar una leyenda
legend("topleft", legend = ticker, col = "blue", lty = 1)

########################### CON 'ggplot2' #########################
library(quantmod)
library(ggplot2)

# Definir el símbolo de la acción y el rango de fechas
ticker <- "GOOGL"
start_date <- "2020-01-01"
end_date <- Sys.Date()

# Obtener los datos históricos de la acción
getSymbols(ticker, from = start_date, to = end_date)
head(GOOGL)

# Calcular la capitalización de mercado (precio de cierre * número de acciones en circulación)
market_cap <- Cl(get(ticker)) * Vo(get(ticker))
tail(market_cap)

# Convertir la serie temporal a un dataframe
market_cap_df <- data.frame(Date = index(market_cap), MarketCap = as.numeric(market_cap))

# Graficar la evolución de la capitalización de mercado utilizando ggplot2
ggplot(market_cap_df, aes(x = Date, y = MarketCap)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución de la Capitalización de Mercado de", ticker),
       x = "Fecha", y = "Capitalización de Mercado (en USD)") +
  theme_minimal() +
  theme(legend.position = "top", legend.title = element_blank(), legend.text = element_text(color = "blue"))

