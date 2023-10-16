# Importa las bibliotecas necesarias
from scipy.optimize import fmin  # Para optimización
import numpy as np               # Para operaciones numéricas
import scipy.stats as si         # Para estadísticas

# Define una función NORMSDIST que calcula la función de distribución acumulativa estándar
def NORMSDIST(x):
    NORMSDIST = si.norm.cdf(x, 0.0, 1.0)
    return(NORMSDIST)

# Define la función MertonEquity para calcular el valor de las acciones
def MertonEquity(V, K, r, T, σV):
    d1 = np.log(V / (K * np.exp(-r * T))) / (σV * np.sqrt(T)) + 0.5 * σV * np.sqrt(T)
    d2 = d1 - σV * np.sqrt(T)
    MertonEquity = V * NORMSDIST(d1) - K * np.exp(-r * T) * NORMSDIST(d2)
    return (MertonEquity)

# Define la función MertonDebt para calcular el valor de la deuda
def MertonDebt(V, K, r, T, σV):
    d1 = np.log(V / (K * np.exp(-r * T))) / (σV * np.sqrt(T)) + 0.5 * σV * np.sqrt(T)
    d2 = d1 - σV * np.sqrt(T)
    MertonDebt = K * np.exp(-r * T) * NORMSDIST(d2) + V * (1 - NORMSDIST(d1))
    return (MertonDebt)

# Definición de variables
S = 20       # Valor de mercado de las acciones
K = 99.46    # Valor nominal de la deuda
r = 0.1      # Tasa de interés libre de riesgo
T = 1        # Plazo en años
σS = 0.4     # Volatilidad del valor de mercado de las acciones

# Define la función ImpliedMerton para optimizar los parámetros V y σV
def ImpliedMerton(c):
    d1 = np.log(c[0] / (K * np.exp(-r * T))) / (c[1] * np.sqrt(T)) + 0.5 * c[1] * np.sqrt(T)
    d2 = d1 - c[1] * np.sqrt(T)
    f1 = (c[0] * NORMSDIST(d1) - K * np.exp(-r * T) * NORMSDIST(d2)) - S
    f2 = σS * S - NORMSDIST(d1) * c[1] * c[0]
    val = f1 ** 2 + f2 ** 2
    print("[V, σV]=", c, ", Object Function Value:", val)
    return (val)

# Utiliza la función fmin de SciPy para encontrar los valores óptimos de V y σV que minimizan la función objetivo
c = fmin(ImpliedMerton, [100, 0.1])
