9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

microsoft <- av_get(symbol = "MSFT", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
microsoft <- microsoft %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
msft.sma <- av_get(symbol = "MSFT", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
msft.ema <- av_get(symbol = "MSFT", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
msft.macd <- av_get(symbol = "MSFT", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
msft.stoch <- av_get(symbol = "MSFT", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
msft.rsi <- av_get(symbol = "MSFT", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
msft.adx <- av_get(symbol = "MSFT", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
msft.cci <- av_get(symbol = "MSFT", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
msft.aroon <- av_get(symbol = "MSFT", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
msft.bbands <- av_get(symbol = "MSFT", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
msft.ad <- av_get(symbol = "MSFT", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
msft.obv <- av_get(symbol = "MSFT", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
microsoft.full <- microsoft %>% 
  left_join(msft.sma,  by = "time") %>% 
  left_join(msft.ema,  by = "time") %>%
  left_join(msft.macd,  by = "time") %>% 
  left_join(msft.stoch,  by = "time") %>%
  left_join(msft.rsi,  by = "time") %>% 
  left_join(msft.adx,  by = "time") %>%
  left_join(msft.cci,  by = "time") %>% 
  left_join(msft.aroon,  by = "time") %>%
  left_join(msft.bbands,  by = "time") %>% 
  left_join(msft.ad,  by = "time") %>%
  left_join(msft.obv,  by = "time")

#Write to CSV
write.csv(microsoft.full, file = "microsoft.full.csv")
