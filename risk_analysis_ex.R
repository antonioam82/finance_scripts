library(quantmod)
library(PerformanceAnalytics)
#library(highcharter)
library(ggplot2)

# DESCARGA DATOS
AMZN = Ad(getSymbols("AMZN",auto.assign = FALSE))
View(AMZN)
BITCOIN = Ad(getSymbols("BTC-USD",auto.assign = FALSE))
plot(BITCOIN,type="l")

# CALCULO LOS RETORNOS O RENTABILIDADES
rAMZN <- dailyReturn(AMZN)

rAMZN2 <- diff(log(AMZN))
hist(rAMZN,breaks = 1000) # histograma 
View(rAMZN)
View(rAMZN2)
plot(rAMZN2,type="l")
rBITCOIN <- dailyReturn(BITCOIN)
plot(rAMZN,type="l")

# CALCULO VAR
var <- VaR(rAMZN, p=0.95, method = "historical")
var
varBTC <- VaR(rBITCOIN, p=0.99, method = "historical")
varBTC*100
# hay una probabilidad de que pierda el 10.47381% de la inversión
