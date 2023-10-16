# Cargar las bibliotecas necesarias
library(quantmod)

# Definir los parámetros del modelo de Merton
S0 <- 100       # Precio actual de la acción
K <- 105        # Precio de ejercicio de la opción
r <- 0.05       # Tasa de interés libre de riesgo
T <- 1          # Plazo en años
sigma_S <- 0.2  # Volatilidad del activo subyacente

# Generar una secuencia de tiempo para simular el precio de la acción
n <- 252        # Número de días de negociación
dt <- T / n     # Incremento de tiempo
t <- seq(0, T, by = dt)
N <- length(t)

# Simulación de precios usando el modelo de Merton
set.seed(123)   # Establecer una semilla para la reproducibilidad
price_path <- numeric(N)
price_path[1] <- S0

for (i in 2:N) {
  dW <- rnorm(1, mean = 0, sd = sqrt(dt))
  price_path[i] <- price_path[i - 1] * exp((r - 0.5 * sigma_S^2) * dt + sigma_S * dW)
}

# Calcular el valor de la opción de compra (call) usando la fórmula de Merton
d1 <- (log(S0 / K) + (r + 0.5 * sigma_S^2) * T) / (sigma_S * sqrt(T))
d2 <- d1 - sigma_S * sqrt(T)
call_price <- S0 * pnorm(d1) - K * exp(-r * T) * pnorm(d2)  # PARA OPCION DE COMPRA
put_price <- K * exp(-r * T) * pnorm(-d2) - S0 * pnorm(-d1) # PARA OPCION DE VENTA


# Resultados
cat("Precio de la acción en el plazo T:", price_path[N], "\n")
cat("Valor de la opción de compra (call):", call_price, "\n")
cat("Vaor de la opción de venta (put):", put_price)
