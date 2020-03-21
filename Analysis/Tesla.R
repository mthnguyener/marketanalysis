9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

Tesla <- av_get(symbol = "TSLA", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
Tesla <- Tesla[-(1:59),] %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
Tsla.sma <- av_get(symbol = "TSLA", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
Tsla.ema <- av_get(symbol = "TSLA", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
Tsla.macd <- av_get(symbol = "TSLA", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")
Tsla.macd <- Tsla.macd[-(2391:2441),]

#Stochastic oscillator (STOCH) values
Tsla.stoch <- av_get(symbol = "TSLA", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")
Tsla.stoch <- Tsla.stoch[-(2391:2441),]

#Relative strength index (RSI) values
Tsla.rsi <- av_get(symbol = "TSLA", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
Tsla.adx <- av_get(symbol = "TSLA", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
Tsla.cci <- av_get(symbol = "TSLA", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
Tsla.aroon <- av_get(symbol = "TSLA", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
Tsla.bbands <- av_get(symbol = "TSLA", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
Tsla.ad <- av_get(symbol = "TSLA", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")
Tsla.ad <- Tsla.ad[-(2391:2449),]

#On balance volume (OBV) values
Tsla.obv <- av_get(symbol = "TSLA", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")
Tsla.obv <- Tsla.obv[-(2391:2449),]

#Combine
Tesla.full <- Tesla %>% 
  left_join(Tsla.sma,  by = "time") %>% 
  left_join(Tsla.ema,  by = "time") %>%
  left_join(Tsla.macd,  by = "time") %>% 
  left_join(Tsla.stoch,  by = "time") %>%
  left_join(Tsla.rsi,  by = "time") %>% 
  left_join(Tsla.adx,  by = "time") %>%
  left_join(Tsla.cci,  by = "time") %>% 
  left_join(Tsla.aroon,  by = "time") %>%
  left_join(Tsla.bbands,  by = "time") %>% 
  left_join(Tsla.ad,  by = "time") %>%
  left_join(Tsla.obv,  by = "time")

#Rename Columns
write.csv(Tesla.full, file = "Tesla.full.csv")