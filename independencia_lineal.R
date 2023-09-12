###################################################################
################# INDEPENDENCIA LINEAL (ACCIONES) #################
###################################################################

# El propósito de este script es, dada una listade acciones,  
# obtener una selección de aquellas (3 en este caso) entre 
# las que existe una menor correlación (mayor independencia)
# Esta técnica se emplea para lograr una mayor diversificación
# en las carteras.

library(quantmod)

# Símbolos de las acciones de las empresas
# Reemplaza estos símbolos con los de las empresas que deseas analizar
#symbols <- c("AAPL", "MSFT", "GOOGL", "AMZN", "KO")
#symbols <- c('KO','AAPL','BAC','CVX','AXP')
symbols <- c('ACS.MC','MAP.MC','TEF.MC','REP.MC','AENA.MC')

# Descargar datos históricos de Yahoo Finance para las acciones
getSymbols(symbols, from = "2022-01-01", to = "2023-01-01")

# Crear un dataframe con los precios ajustados de las acciones
price_data <- na.omit(Ad(merge(get(symbols[1]), get(symbols[2]), get(symbols[3]), get(symbols[4]), get(symbols[5]))))

# Calcular los retornos diarios
returns_data <- 100 * na.omit(returns(price_data))

# Calcular la matriz de correlación
correlation_matrix <- cor(returns_data)

# Definir el tamaño de las submatrices
subsize <- 3  # Puedes ajustar esto según tus necesidades

# Encontrar las combinaciones de activos con los determinantes más altos
combinations <- combn(ncol(returns_data), subsize)
determinants <- numeric(ncol(combinations))

for (i in 1:ncol(combinations)) {
  submatrix <- returns_data[, combinations[, i]]
  determinants[i] <- det(cor(submatrix))
}

# Encontrar la combinación con el determinante máximo
max_determinant_index <- which.max(determinants)
selected_combination <- combinations[, max_determinant_index]

# Crear un nuevo dataframe con las acciones seleccionadas
selected_data <- data.frame(returns_data[, selected_combination])

# Renombrar las columnas con los nombres de las acciones seleccionadas
colnames(selected_data) <- symbols[selected_combination]

# Imprimir la combinación seleccionada
print("Combinación de acciones seleccionada:")
print(selected_combination)

# Imprimir el dataframe con las acciones seleccionadas
print("Dataframe con los retornos de las acciones seleccionadas:")
print(head(selected_data))

names(selected_data)
