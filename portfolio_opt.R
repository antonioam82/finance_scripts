# Introducci?n a R para Finanzas Cuantitativas
# Optimizaci?n de un portafolio

#Librer?as requeridas
library("quantmod")
library("timeSeries")
library("fPortfolio")
library("caTools")
library("dplyr")
library("PerformanceAnalytics")
library("ggplot2")

###########################################################
###################### PASOS PREVIOS ######################
###########################################################

#Vector de TICKERS

#tickers<-c("TSLA","NEM","NFLX", "BAC","AMZN","JNJ")
#tickers<-c("TSLA","IBM","NFLX","GOOGL","AMZN","JNJ")
#tickers<-c("JNJ","NVDA","IBM","DIS")
#tickers <- c("ORA.PA","ZURN.SW","BTLCY","NGG")
tickers <- c('GWW','ES','HSY','MCK','NVR')
#tickers <- c("HD","NVDA")

#Extrayendo la data

PrecPort<- NULL
for (Ticker in tickers)
PrecPort<-cbind(PrecPort, getSymbols(Ticker, from= '2019-01-01', auto.assign=FALSE)[,4])
PrecPort 

#Renombrando los encabezados de las columnas

colnames(PrecPort)<-tickers

#Calculando los retornos

RetPort <- na.omit(ROC(PrecPort, type="discrete"))
RetPort
#Convirtiendo los retornos en series de tiempo
RetPort <- as.timeSeries(RetPort)

RetPort

###############################################################################
###################### FRONTERA Y PORTAFOLIOS EFICIENTES ######################
###############################################################################

#Calculando la frontera eficiente

fronteraEff <- portfolioFrontier(RetPort, constraints= "LongOnly")


#Graficando la frontera
#En el gr?fico, se pueden incorporar los siguientes elementos:
# 1: Frontera Eficiente
# 2: El portafolio con la m?nima varianza global
# 3: L?nea tangente al portafolio
# 4: Riesgo y retorno de cada activo
# 5: Portafolio con activos del mismo peso
# 6: Fronteras de dos activos
# 7: Portafolios de Monte Carlo
# 8: Ratio de Sharpe

plot(fronteraEff,c(1,2,3,8))


#Riesgos y Retornos de la frontera

Riesgo_Retorno <- frontierPoints(fronteraEff)
Riesgo_Retorno

#Matrices de correlaci?n y covarianza

MatrizCorr<-cor(RetPort)
MatrizCov<-cov(RetPort)

MatrizCov
MatrizCorr

#Pesos en las fronteras eficientes
fronteraPesos<-getWeights(fronteraEff)
colnames(fronteraPesos)<-tickers

barplot(t(fronteraPesos), main="Pesos de los activos en la Frontera Eficiente",col=cm.colors(ncol(fronteraPesos)+2), legend=colnames(fronteraPesos))


#Puntos interesantes:

  #Varianza minima global
  VMG<-minvariancePortfolio(RetPort, spec=portfolioSpec(), constraints="LongOnly")
  VMG
  
    #Reporte de los pesos asignados:
    VMG_Pesos<-getWeights(VMG)
    DF_VMG_Pesos<-data.frame(VMG_Pesos)
    acciones<-colnames(fronteraPesos)
    ggplot(data=DF_VMG_Pesos,aes(x=acciones,y=VMG_Pesos,fill=acciones))+
      geom_bar(stat="identity",position=position_dodge(),colour="black")+
      geom_text(aes(label=sprintf("%.02f %%",VMG_Pesos*100)),
                position=position_dodge(width=0.9),vjust=-0.25,check_overlap=TRUE)+
      ggtitle("Pesos de las acciones del portafolio de varianza minima global")+
      theme(plot.title = element_text(hjust=0.5))+
      labs(x="Acciones",y="Pesos (%)")
      
  #Punto de la Linea de Mercado de Capitales tangente a la Frontera Eficiente  
  LMC<-tangencyPortfolio(RetPort, spec=portfolioSpec(), constraints="LongOnly")
  LMC
  
    #Reporte de los pesos asignados:
    LMC_Pesos<-getWeights(LMC)
    DF_LMC_Pesos<-data.frame(LMC_Pesos)
    acciones<-colnames(fronteraPesos)
    ggplot(data=DF_LMC_Pesos,aes(x=acciones,y=LMC_Pesos,fill=acciones))+
      geom_bar(stat="identity",position=position_dodge(),colour="black")+
      geom_text(aes(label=sprintf("%.02f %%",LMC_Pesos*100)),
                position=position_dodge(width=0.9),vjust=-0.25,check_overlap=TRUE)+
      ggtitle("Pesos de las acciones del portafolio de mercado")+
      theme(plot.title = element_text(hjust=0.5))+
      labs(x="Acciones",y="Pesos (%)")
    
    
###########################################################
    # Calcular el retorno y la volatilidad de la cartera VMG
    retorno_cartera_vmg <- sum(VMG_Pesos * colMeans(RetPort))
    volatilidad_cartera_vmg <- sqrt(t(VMG_Pesos) %*% MatrizCov %*% VMG_Pesos)
    
    # Calcular el retorno y la volatilidad de la cartera LMC
    retorno_cartera_lmc <- sum(LMC_Pesos * colMeans(RetPort))
    volatilidad_cartera_lmc <- sqrt(t(LMC_Pesos) %*% MatrizCov %*% LMC_Pesos)
    
    # Calcular el ratio Sharpe de la cartera VMG
    rf_rate <- 0.0  # Tasa libre de riesgo (puedes ajustarla)
    sharpe_ratio_vmg <- (retorno_cartera_vmg - rf_rate) / volatilidad_cartera_vmg
    
    # Calcular el ratio Sharpe de la cartera LMC
    sharpe_ratio_lmc <- (retorno_cartera_lmc - rf_rate) / volatilidad_cartera_lmc
    
    # Calcular la prima de riesgo de la cartera VMG
    prima_riesgo_vmg <- retorno_cartera_vmg - rf_rate
    
    # Calcular la prima de riesgo de la cartera LMC
    prima_riesgo_lmc <- retorno_cartera_lmc - rf_rate
    
    # Mostrar los resultados, incluyendo la prima de riesgo
    cat("Cartera de Varianza Mínima Global (VMG):\n")
    cat("Retorno de la Cartera: ", retorno_cartera_vmg, "\n")
    cat("Volatilidad de la Cartera: ", volatilidad_cartera_vmg, "\n")
    cat("Prima de Riesgo de la Cartera: ", prima_riesgo_vmg * 100, "\n")
    cat("Ratio Sharpe de la Cartera: ", sharpe_ratio_vmg, "\n\n")
    
    cat("Cartera de Linea de Mercado de Capitales (LMC):\n")
    cat("Retorno de la Cartera: ", retorno_cartera_lmc, "\n")
    cat("Volatilidad de la Cartera: ", volatilidad_cartera_lmc, "\n")
    cat("Prima de Riesgo de la Cartera: ", prima_riesgo_lmc * 100, "\n")
    cat("Ratio Sharpe de la Cartera: ", sharpe_ratio_lmc, "\n")
