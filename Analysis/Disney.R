9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

disney <- av_get(symbol = "DIS", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
disney <- disney %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
dis.sma <- av_get(symbol = "DIS", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
dis.ema <- av_get(symbol = "DIS", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
dis.macd <- av_get(symbol = "DIS", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
dis.stoch <- av_get(symbol = "DIS", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
dis.rsi <- av_get(symbol = "DIS", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
dis.adx <- av_get(symbol = "DIS", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
dis.cci <- av_get(symbol = "DIS", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
dis.aroon <- av_get(symbol = "DIS", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
dis.bbands <- av_get(symbol = "DIS", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
dis.ad <- av_get(symbol = "DIS", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
dis.obv <- av_get(symbol = "DIS", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
disney.full <- disney %>% 
  left_join(dis.sma,  by = "time") %>% 
  left_join(dis.ema,  by = "time") %>%
  left_join(dis.macd,  by = "time") %>% 
  left_join(dis.stoch,  by = "time") %>%
  left_join(dis.rsi,  by = "time") %>% 
  left_join(dis.adx,  by = "time") %>%
  left_join(dis.cci,  by = "time") %>% 
  left_join(dis.aroon,  by = "time") %>%
  left_join(dis.bbands,  by = "time") %>% 
  left_join(dis.ad,  by = "time") %>%
  left_join(dis.obv,  by = "time")

#Write to CSV
write.csv(disney.full, file = "disney.full.csv")
