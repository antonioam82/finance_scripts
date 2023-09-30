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

########################Usando test de Dickey-Fuller########################


# Descargar datos de Yahoo Finance (reemplaza con tus símbolos de acciones y fechas)
getSymbols(c("AAPL", "MSFT"), from = "2020-01-01", to = "2021-01-01")

# Extraer los precios de cierre ajustados de las acciones
stock1 <- Ad(AAPL)
stock2 <- Ad(MSFT)

# Ajustar un modelo de regresión lineal
lm_model <- lm(stock1 ~ stock2)

# Calcular los residuos del modelo
residuals <- resid(lm_model)

# Realizar la prueba de Dickey-Fuller Aumentado para stock1
adf_test_stock1 <- ur.df(stock1, lags = 0, type = "trend")

# Realizar la prueba de Dickey-Fuller Aumentado para stock2
adf_test_stock2 <- ur.df(stock2, lags = 0, type = "trend")

adf_test_residuals <- ur.df(residuals, lags = 0, type = "trend")

# Imprimir los resultados de las pruebas
print("Prueba de Dickey-Fuller Aumentado para stock1:")
print(summary(adf_test_stock1))

print("\nPrueba de Dickey-Fuller Aumentado para stock2:")
print(summary(adf_test_stock2))

print("\nPrueba de Dickey-Fuller Aumentado para los residuos del modelo:")
print(summary(adf_test_residuals))

