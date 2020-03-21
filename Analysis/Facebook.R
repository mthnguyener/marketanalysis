9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

facebook <- av_get(symbol = "FB", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
facebook <- facebook %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
fb.sma <- av_get(symbol = "FB", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
fb.ema <- av_get(symbol = "FB", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
fb.macd <- av_get(symbol = "FB", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
fb.stoch <- av_get(symbol = "FB", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
fb.rsi <- av_get(symbol = "FB", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
fb.adx <- av_get(symbol = "FB", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
fb.cci <- av_get(symbol = "FB", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
fb.aroon <- av_get(symbol = "FB", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
fb.bbands <- av_get(symbol = "FB", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
fb.ad <- av_get(symbol = "FB", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
fb.obv <- av_get(symbol = "FB", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
facebook.full <- facebook %>% 
  left_join(fb.sma,  by = "time") %>% 
  left_join(fb.ema,  by = "time") %>%
  left_join(fb.macd,  by = "time") %>% 
  left_join(fb.stoch,  by = "time") %>%
  left_join(fb.rsi,  by = "time") %>% 
  left_join(fb.adx,  by = "time") %>%
  left_join(fb.cci,  by = "time") %>% 
  left_join(fb.aroon,  by = "time") %>%
  left_join(fb.bbands,  by = "time") %>% 
  left_join(fb.ad,  by = "time") %>%
  left_join(fb.obv,  by = "time")

#Write to CSV
write.csv(facebook.full, file = "facebook.full.csv")
