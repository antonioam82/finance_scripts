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
market_cap <- Cl(get(ticker)) * Op(get(ticker))
tail(market_cap)

# Graficar la evolución de la capitalización de mercado
plot(index(market_cap), market_cap, type = "l", col = "blue",
     main = paste("Evolución de la Capitalización de Mercado de", ticker),
     xlab = "Fecha", ylab = "Capitalización de Mercado (en USD)")

# Agregar una leyenda
legend("topleft", legend = ticker, col = "blue", lty = 1)
