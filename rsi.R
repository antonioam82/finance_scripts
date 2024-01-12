# Cargar la librería quantmod
library(quantmod)

# Establecer el símbolo de la acción y la fuente de datos (Yahoo Finance)
stock_symbol <- "TSLA"  # Cambia AAPL por el símbolo de la acción que desees

# Obtener los datos históricos de la acción
getSymbols(stock_symbol, src = "yahoo", from = "2023-01-01")

# Calcular el RSI con un período de 14 días
rsi_14 <- RSI(Cl(get(stock_symbol)), n = 14)

# Imprimir los últimos valores del RSI
tail(rsi_14)

plot(rsi_14,type='l')

# Imprimir los últimos valores del RSI
cat("Últimos valores del RSI:\n", tail(rsi_14), "\n")

titulo <- paste("Precio de ", stock_symbol)

# Crear un gráfico con el precio de cierre y el RSI
chart_Series(get(stock_symbol), name = titulo, TA = "add_RSI(n = 14)")
