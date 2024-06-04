#install.packages("alphavantager")
#install.packages("quantmod")
#install.packages("ggplot2")
library(alphavantager)
library(quantmod)
library(ggplot2)

av_api_key("tu_clave_api_aqui")

# Definir el símbolo de la acción
ticker <- "QCOM"

# Obtener datos financieros clave utilizando la función `av_get`
financial_data <- av_get(symbol = ticker, datatype = "json", av_fun = "OVERVIEW")
#financial_data <- av_get(symbol = ticker, datatype = "json", av_fun = "GLOBAL_QUOTE")

# Mostrar todas las columnas disponibles en financial_data
print(financial_data)

################################################################################

# Configurar la clave API de Alpha Vantage
av_api_key("tu_clave_api_aqui")

# Definir el símbolo de la acción
ticker <- "QCOM"

# Obtener datos financieros clave utilizando la función `av_get`
financial_data <- av_get(symbol = ticker, datatype = "json", av_fun = "OVERVIEW")

# Mostrar la estructura del objeto financial_data para verificar su contenido
str(financial_data)

# Extraer la descripción de financial_data
#description <- financial_data$value[financial_data$rank_group == "Description"]
description <- financial_data$value[4]
description

# Mostrar la descripción
if (length(description) > 0) {
  print(description)
} else {
  print("El campo 'Description' no está disponible en los datos obtenidos.")
}
