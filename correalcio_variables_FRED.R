library(quantmod)
library(ggplot2)

# Establecer el código del índice de producción industrial (por ejemplo, el índice de producción industrial de EE. UU.)
ticker <- "UMCSENT"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
conf_consum <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
conf_consum
head(conf_consum)

fecha_predefinida <- as.Date("1992-01-01")

conf_consum <- subset(conf_consum, Date >= fecha_predefinida)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(conf_consum, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del Indice de Confianza del cOnsumidos (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

#######

ticker <- "GDPC1"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
PIB <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
PIB
head(PIB)

fecha_predefinida <- as.Date("1992-01-01")

PIB <- subset(PIB, Date >= fecha_predefinida)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(PIB, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del Porducto Interior Bruto EEUU (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

##############

ticker <- "USSLIND"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
act_econ <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
act_econ
head(act_econ)

fecha_predefinida <- as.Date("1992-01-01")

act_econ <- subset(act_econ, Date >= fecha_predefinida)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(act_econ, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del Indice de Actividad Economica EEUU (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

##############################

ticker <- "CSUSHPINSA"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
precio_vivienda <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
precio_vivienda
head(precio_vivienda)

fecha_predefinida <- as.Date("1992-01-01")

precio_vivienda <- subset(precio_vivienda, Date >= fecha_predefinida)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(precio_vivienda, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del Precio de la Vivienda EEUU (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

################


ticker <- "FPCPITOTLZGUSA"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
tasa_inflaccion <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
tasa_inflaccion
head(tasa_inflaccion)

fecha_predefinida <- as.Date("1992-01-01")

tasa_inflaccion <- subset(tasa_inflaccion, Date >= fecha_predefinida)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(tasa_inflaccion, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del la Tasa de Inflaccion EEUU (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

#################

ticker <- "INDPRO"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
produccion_indust <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
produccion_indust
head(produccion_indust)

fecha_predefinida <- as.Date("1992-01-01")

produccion_indust <- subset(produccion_indust, Date >= fecha_predefinida)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(produccion_indust, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del la Tasa de Produccion Industrial EEUU (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

####################################

ticker <- "UNRATE"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
desempleo <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
desempleo
head(desempleo)

fecha_predefinida <- as.Date("1992-01-01")

desempleo <- subset(desempleo, Date >= fecha_predefinida)
head(desempleo)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(desempleo, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del la Tasa de Desemple EEUU (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

#############################

ticker <- "IPMAN"


# Obtener los datos históricos del índice de producción industrial
getSymbols(ticker, src = "FRED")

# Crear un dataframe con los datos
prod_in_manu <- data.frame(Date = index(get(ticker)), Index = as.numeric(get(ticker)))
prod_in_manu
head(prod_in_manu)

fecha_predefinida <- as.Date("1992-01-01")

prod_in_manu <- subset(prod_in_manu, Date >= fecha_predefinida)
head(prod_in_manu)

# Visualizar la evolución del índice de producción industrial usando ggplot2
ggplot(prod_in_manu, aes(x = Date, y = Index)) +
  geom_line(color = "blue") +
  labs(title = paste("Evolución del la Tasa de Produccion Indistrial-Manufacturas EEUU (", ticker, ")"),
       x = "Fecha",
       y = "Índice") +
  theme_minimal()

# Renombrar las columnas 'Index' en cada dataframe
names(conf_consum)[2] <- "conf_consum"
names(PIB)[2] <- "PIB"
names(act_econ)[2] <- "act_econ"
names(precio_vivienda)[2] <- "precio_vivienda"
names(tasa_inflaccion)[2] <- "tasa_inflaccion"
names(produccion_indust)[2] <- "produccion_indust"
names(desempleo)[2] <- "desempleo"
names(prod_in_manu)[2] <- "prod_in_manu"

# Combina los dataframes en uno solo
combined_data <- merge(conf_consum, PIB, by = "Date", all = TRUE)
combined_data <- merge(combined_data, act_econ, by = "Date", all = TRUE)
combined_data <- merge(combined_data, precio_vivienda, by = "Date", all = TRUE)
combined_data <- merge(combined_data, tasa_inflaccion, by = "Date", all = TRUE)
combined_data <- merge(combined_data, produccion_indust, by = "Date", all = TRUE)
combined_data <- merge(combined_data, desempleo, by = "Date", all = TRUE)
combined_data <- merge(combined_data, prod_in_manu, by = "Date", all = TRUE)

# Selecciona las fechas a partir de la fecha predefinida
combined_data <- subset(combined_data, Date >= fecha_predefinida)

# Extrae solo las columnas numéricas para calcular la matriz de correlación
numeric_data <- combined_data[, sapply(combined_data, is.numeric)]

# Calcula la matriz de correlación
correlation_matrix <- cor(numeric_data, use = "complete.obs")

# Añade los nombres de las variables a la matriz de correlación
rownames(correlation_matrix) <- colnames(correlation_matrix) <- names(numeric_data)

# Gráfica de la matriz de correlación con valores en cada celda
ggplot(data = as.data.frame(as.table(correlation_matrix)),
       aes(x = Var1, y = Var2, fill = Freq, label = sprintf("%.2f", Freq))) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.2f", Freq)), vjust = 1) +  # Añadir valores en cada celda
  scale_fill_gradient(low = "blue", high = "red") +
  labs(title = "Matriz de Correlación entre Indicadores",
       x = "Indicador",
       y = "Indicador",
       fill = "Correlación") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
