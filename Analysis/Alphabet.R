9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

alphabet <- av_get(symbol = "GOOGL", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
alphabet <- alphabet %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
googl.sma <- av_get(symbol = "GOOGL", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
googl.ema <- av_get(symbol = "GOOGL", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
googl.macd <- av_get(symbol = "GOOGL", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
googl.stoch <- av_get(symbol = "GOOGL", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
googl.rsi <- av_get(symbol = "GOOGL", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
googl.adx <- av_get(symbol = "GOOGL", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
googl.cci <- av_get(symbol = "GOOGL", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
googl.aroon <- av_get(symbol = "GOOGL", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
googl.bbands <- av_get(symbol = "GOOGL", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
googl.ad <- av_get(symbol = "GOOGL", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
googl.obv <- av_get(symbol = "GOOGL", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
alphabet.full <- alphabet %>% 
  left_join(googl.sma,  by = "time") %>% 
  left_join(googl.ema,  by = "time") %>%
  left_join(googl.macd,  by = "time") %>% 
  left_join(googl.stoch,  by = "time") %>%
  left_join(googl.rsi,  by = "time") %>% 
  left_join(googl.adx,  by = "time") %>%
  left_join(googl.cci,  by = "time") %>% 
  left_join(googl.aroon,  by = "time") %>%
  left_join(googl.bbands,  by = "time") %>% 
  left_join(googl.ad,  by = "time") %>%
  left_join(googl.obv,  by = "time")

#Write to CSV
write.csv(alphabet.full, file = "alphabet.full.csv")
