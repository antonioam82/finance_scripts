# Introducci?n a R para Finanzas Cuantitativas
# Optimizaci?n de un portafolio
# Autor: Jhonatan Ever Medina Muriel

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
tickers<-c("JNJ","NVDA","IBM")
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
      ggtitle("Pesos de las acciones del portafolio de varianza m?nima global")+
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
    
    # Calcular la frontera eficiente
    fronteraEff <- portfolioFrontier(RetPort, constraints = "LongOnly")
    
    # Calcular la cartera de mínima varianza global
    VMG <- minvariancePortfolio(RetPort, spec = portfolioSpec(), constraints = "LongOnly")
    VMG_Pesos <- getWeights(VMG)
    
    # Calcular la cartera tangente a la frontera eficiente (Línea de Mercado de Capitales)
    LMC <- tangencyPortfolio(RetPort, spec = portfolioSpec(), constraints = "LongOnly")
    LMC_Pesos <- getWeights(LMC)
    
    # Obtener información de riesgo, retorno y Ratio Sharpe
    ret_VMG <- sum(VMG_Pesos * colMeans(RetPort))
    vol_VMG <- sqrt(t(VMG_Pesos) %*% MatrizCov %*% VMG_Pesos)
    sharpe_VMG <- ret_VMG / vol_VMG
    
    ret_LMC <- sum(LMC_Pesos * colMeans(RetPort))
    vol_LMC <- sqrt(t(LMC_Pesos) %*% MatrizCov %*% LMC_Pesos)
    sharpe_LMC <- ret_LMC / vol_LMC
    
    # Imprimir información por pantalla
    cat("Cartera de Mínima Varianza Global:\n")
    cat("-------------------------------\n")
    cat("Retorno:", ret_VMG, "\n")
    cat("Volatilidad:", vol_VMG, "\n")
    cat("Ratio Sharpe:", sharpe_VMG, "\n\n")
    
    cat("Cartera Tangente a la Frontera Eficiente:\n")
    cat("---------------------------------------\n")
    cat("Retorno:", ret_LMC, "\n")
    cat("Volatilidad:", vol_LMC, "\n")
    cat("Ratio Sharpe:", sharpe_LMC, "\n")
