9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

amazon <- av_get(symbol = "AMZN", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
amazon <- amazon %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
amzn.sma <- av_get(symbol = "AMZN", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
amzn.ema <- av_get(symbol = "AMZN", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
amzn.macd <- av_get(symbol = "AMZN", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
amzn.stoch <- av_get(symbol = "AMZN", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
amzn.rsi <- av_get(symbol = "AMZN", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
amzn.adx <- av_get(symbol = "AMZN", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
amzn.cci <- av_get(symbol = "AMZN", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
amzn.aroon <- av_get(symbol = "AMZN", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
amzn.bbands <- av_get(symbol = "AMZN", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
amzn.ad <- av_get(symbol = "AMZN", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
amzn.obv <- av_get(symbol = "AMZN", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
amazon.full <- amazon %>% 
  left_join(amzn.sma,  by = "time") %>% 
  left_join(amzn.ema,  by = "time") %>%
  left_join(amzn.macd,  by = "time") %>% 
  left_join(amzn.stoch,  by = "time") %>%
  left_join(amzn.rsi,  by = "time") %>% 
  left_join(amzn.adx,  by = "time") %>%
  left_join(amzn.cci,  by = "time") %>% 
  left_join(amzn.aroon,  by = "time") %>%
  left_join(amzn.bbands,  by = "time") %>% 
  left_join(amzn.ad,  by = "time") %>%
  left_join(amzn.obv,  by = "time")

#Write to CSV
write.csv(amazon.full, file = "amazon.full.csv")
