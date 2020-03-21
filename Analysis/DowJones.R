9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

dowjones <- av_get(symbol = ".DJI", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
dowjones <- dowjones %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
dji.sma <- av_get(symbol = ".DJI", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
dji.ema <- av_get(symbol = ".DJI", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
dji.macd <- av_get(symbol = ".DJI", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
dji.stoch <- av_get(symbol = ".DJI", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
dji.rsi <- av_get(symbol = ".DJI", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
dji.adx <- av_get(symbol = ".DJI", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
dji.cci <- av_get(symbol = ".DJI", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
dji.aroon <- av_get(symbol = ".DJI", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
dji.bbands <- av_get(symbol = ".DJI", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
dji.ad <- av_get(symbol = ".DJI", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
dji.obv <- av_get(symbol = ".DJI", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
dowjones.full <- dowjones %>% 
  left_join(dji.sma,  by = "time") %>% 
  left_join(dji.ema,  by = "time") %>%
  left_join(dji.macd,  by = "time") %>% 
  left_join(dji.stoch,  by = "time") %>%
  left_join(dji.rsi,  by = "time") %>% 
  left_join(dji.adx,  by = "time") %>%
  left_join(dji.cci,  by = "time") %>% 
  left_join(dji.aroon,  by = "time") %>%
  left_join(dji.bbands,  by = "time") %>% 
  left_join(dji.ad,  by = "time") %>%
  left_join(dji.obv,  by = "time")

#Write to CSV
write.csv(dowjones.full, file = "dowjones.full.csv")
