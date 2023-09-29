library(quantmod)
library(urca)

# Descargar datos de Yahoo Finance (reemplaza con tus símbolos de acciones y fechas)
getSymbols(c("AAPL", "MSFT"), from = "2020-01-01", to = "2021-01-01")

# Extraer los precios de cierre ajustados de las acciones
stock1 <- Ad(AAPL)
stock2 <- Ad(MSFT)

# Ajustar un modelo de regresión lineal
lm_model <- lm(stock1 ~ stock2)

# Calcular los residuos del modelo
residuals <- resid(lm_model)
hist(residuals, main="Histograma de Residuos", xlab="Residuos")

# Realizar la prueba de cointegración Engle-Granger
cointegration_test <- ca.jo(data.frame(stock1, stock2), type = "eigen", K = 2)
cointegration_test

# Imprimir los resultados de la prueba
summary(cointegration_test)
