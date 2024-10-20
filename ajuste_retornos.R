# Instalar y cargar las librerías necesarias
# install.packages(c("quantmod", "ggplot2", "fitdistrplus", "MASS"))
library(quantmod)
library(ggplot2)
library(tidyverse)

# Definir el símbolo y rango de fechas
ticker <- "GOOGL"
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
plot(returns)

mu_a <- mean(returns) #media
sigma_a <- sd(returns) #desviacion estandar

# Graficar la distribución de los retornos
ggplot(data = as.data.frame(returns), aes_string(x = ticker)) +
  geom_histogram(bins = 50, fill = "blue", alpha = 0.6) +
  geom_vline(aes(xintercept = mean(returns)), color = "yellow", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = sd(returns)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = -sd(returns)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 2 * sd(returns)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = -2 * sd(returns)), color = "red", linetype = "dashed", size = 1) +
  ggtitle(paste("Variación de los retornos de", ticker)) +
  xlab("Retornos") +
  ylab("Frecuencia")

hist(returns, breaks = 50, freq = F)
lines(density(returns),col='green',lwd=2)
lines(seq(-0.15,0.15,0.00001),dnorm(seq(-0.15,0.15,0.00001),mu_a,sigma_a),type="l",col="red",lwd=2)



################################################################################

IBEX <- getSymbols('^IBEX', auto.assign = F)["2011/2024"] %>% Cl() %>% na.omit()
tail(IBEX)

log_r_IBEX <- diff(log(IBEX))[-1]
log_r_IBEX <- log_r_IBEX[log_r_IBEX$IBEX.Close != 0]

plot(IBEX)
plot(log_r_IBEX)

mu <- mean(log_r_IBEX) #media
sigma <- sd(log_r_IBEX) #desviacion estandar

hist(log_r_IBEX, breaks = 50, freq = F)
lines(density(log_r_IBEX),col='green',lwd=2)
lines(seq(-0.15,0.15,0.00001),dnorm(seq(-0.15,0.15,0.00001),mu,sigma),type="l",col="red",lwd=2)

legend(x=0.01,y=40,legend=c(expression(paste("N(",mu["IBEX"],",",sigma["IBEX"],") ajustada")),"densidad Kernel"),
       lty = c(1,1),lwd = c(3,3),
       col=c("red","green"),
       inset = 0.0,pt.lwd = 1,pt.cex = 2,cex = 1,bty = "n",seg.len = 0.5)





