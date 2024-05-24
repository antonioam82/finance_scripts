library(tidyverse)
library(tidyquant)
library(gganimate)#
library(av)#
library(gifski)#

ACCIONES <- tq_get(c("GOOGL","AMZN","PFE","AAPL"),
                   get="stock.prices")
ACCIONES

fecha_inicial <- ACCIONES$date[1]
fecha_final <- ACCIONES$date[nrow(ACCIONES)]

ACCIONES %>%
  ggplot(aes(date,close,color=symbol)) +
  geom_line()+
  facet_wrap(~symbol,ncol=2,scales="free")+
  theme_tq()+
  theme(legend.position = "none")+
  xlab(NULL)+
  ylab(NULL)+
  ggtitle("Precio de Cierre de Apple, Amazon, Google y Pfeize",
          subtitle = paste("Desde ", fecha_inicial, " hasta ", fecha_final))
