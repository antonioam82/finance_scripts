# Instalar y cargar las librerías necesarias
# install.packages(c("quantmod", "ggplot2", "fitdistrplus", "MASS"))
library(quantmod)
library(ggplot2)
library(tidyverse)

# Definir el símbolo y rango de fechas
ticker <- "AAPL"
start_date <- "2015-01-01"
end_date <- Sys.Date()

# Obtener datos históricos del índice
getSymbols(ticker, from = start_date, to = end_date)
data <- Cl(get(ticker))

# Calcular los retornos diarios
returns <- diff(log(data))[-1]
colnames(returns) <- ticker
print(head(returns))

returns <- na.omit(returns)

# Graficar la distribución de los retornos
ggplot(data = as.data.frame(returns), aes_string(x = ticker)) +
  geom_histogram(bins = 150, fill = "blue", alpha = 0.6) +
  geom_vline(aes(xintercept = mean(returns)), color = "yellow", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = sd(returns)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = -sd(returns)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 2 * sd(returns)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = -2 * sd(returns)), color = "red", linetype = "dashed", size = 1) +
  ggtitle(paste("Variación de los retornos de", ticker)) +
  xlab("Retornos") +
  ylab("Frecuencia")

################################################################################

IBEX <- getSymbols('^IBEX', auto.assign = F)["2011/2024"] %>% Cl() %>% na.omit()
tail(IBEX)

log_r_IBEX <- diff(log(IBEX))[-1]
log_r_IBEX <- log_r_IBEX[log_r_IBEX$IBEX.Close != 0]

plot(IBEX)
plot(log_r_IBEX)

mu <- mean(log_r_IBEX) #media
sigma <- sd(log_r_IBEX) #desviacion estandar

