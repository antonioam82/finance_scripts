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

#######################################bet########################################

library(fImport)
library(fPortfolio)
library(gtools)
library(TSA)
library(tseries)

exusuk=na.omit(fredSeries(c("DEXUSUK"),from="2021-01-01"))
exszus=na.omit(fredSeries(c("DEXSZUS"),from="2021-01-01"))
excaus=na.omit(fredSeries(c("DEXCAUS"),from="2021-01-01"))

# PASO 1 COMPROBAR QUE LAS SERIES SON I(1)
y <- exusuk
plot(y,type="l")
adf.test(y)
y.1 <- na.omit(diff(y))
plot(y.1,type="l")
adf.test(y.1)

x <- exszus
plot(x,type="l")
adf.test(x)
x.1<-na.omit(diff(x))
plot(x.1,type="l")
adf.test(x.1)

z <- excaus
plot(z,type="l")
adf.test(z)
z.1<-na.omit(diff(z))
plot(z.1,type="l")
adf.test(z.1)

# PASO 2 REGRESION LINEAL

regresion <- lm(y~x+z)
summary(regresion)

# obtener residuos del modelo
residuos <- residuals(regresion)
plot(residuos,type="l")

adf.test(residuos)

# extraer la beta
beta = coef(regresion)
beta

# PASO 3 CREAR EL SPREAD

pendiente = beta[1]+x*beta[2]+z*beta[3]
spread = pendiente - y
spread
plot(spread,type="l")

# PASO 4 DTERMINAR LOS PUNTOS DE ENTRADA Y SALIDA

# Calculo de las desviacion tipica y de la media

desv <- sd(spread)
media <- mean(desv)

sd1 <- media + desv
sd11 <- media - desv
sd2 <- media + 2 * desv
sd22 <- media - 2 * desv

plot(spread,type="l")
abline(media,0,col="blue")
abline(sd1,0,col="green")
abline(sd11,0,col="green")
abline(sd2,0,col="red")
abline(sd22,0,col="red")

# entradas 
beta[1]
beta[2]
beta[3]


