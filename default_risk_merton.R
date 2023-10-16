# Cálculo de la probabilidad de default (PD) según el modelo de Merton

# Parámetros del modelo
S <- 20  # Valor de mercado de la empresa
K <- 99.46   # Valor nominal de la deuda
r <- 0.1 # Tasa de interés libre de riesgo
T <- 1    # Plazo de la deuda en años
sigma <- 0.4 # Volatilidad de los activos

# Cálculo de la distancia a la quiebra (Distance to Default, DD)
DD <- log(S / K) + (r + (sigma^2) / 2) * T
DD <- DD / (sigma * sqrt(T))

# Establecer una función de distribución acumulativa normal estándar
NORMSDIST <- function(x) {
  pnorm(x, mean = 0, sd = 1)
}

# Calcular la probabilidad de default (PD)
PD <- 1 - NORMSDIST(-DD)

cat("Distancia a la quiebra (DD):", DD, "\n")
cat("Probabilidad de default (PD):", PD, "\n")

# Interpreta el resultado
if (PD > 0.05) {
  cat("La probabilidad de default es alta. La empresa enfrenta un alto riesgo de quiebra.\n")
} else {
  cat("La probabilidad de default es baja. La empresa tiene un riesgo de quiebra relativamente bajo.\n")
}
