library(WDI)
library(dplyr)
library(ggplot2)

country_code <- "US"
start_year <- 1990
end_year <- 2024

# Obtener datos del Banco Mundial
data <- WDI(
  country = country_code,
  indicator = c("IPTOTSAKD"), #IPTOTNSKD
  start = start_year,
  end = end_year
)

# Renombrar las columnas para facilitar el manejo
data <- data %>%
  rename(Indust = IPTOTSAKD, Year = year)

#Eliminar datos faltantes (si los hay)
data <- na.omit(data)


# Visualización de la evolución del Indice de Produccion Industrial
ggplot(data, aes(x = Year, y = Indust)) +
  geom_line(color = "blue", size = 1.5) +
  geom_point(color = "red", size = 2) +
  labs(title = paste("Evolución de produccion industrial", country_code),
       x = "Año", 
       y = "Valor") +
  theme_minimal()
