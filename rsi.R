# Cargar la librería quantmod
library(quantmod)

# Establecer el símbolo de la acción y la fuente de datos (Yahoo Finance)
stock_symbol <- "TSLA"  # Cambia AAPL por el símbolo de la acción que desees

# Obtener los datos históricos de la acción
getSymbols(stock_symbol, src = "yahoo")

# Calcular el RSI con un período de 14 días
rsi_14 <- RSI(Cl(get(stock_symbol)), n = 14)

# Imprimir los últimos valores del RSI
tail(rsi_14)

plot(rsi_14,type='l')
