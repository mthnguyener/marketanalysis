9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

apple <- av_get(symbol = "AAPL", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
apple <- apple %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
aapl.sma <- av_get(symbol = "AAPL", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
aapl.ema <- av_get(symbol = "AAPL", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
aapl.macd <- av_get(symbol = "AAPL", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
aapl.stoch <- av_get(symbol = "AAPL", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
aapl.rsi <- av_get(symbol = "AAPL", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
aapl.adx <- av_get(symbol = "AAPL", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
aapl.cci <- av_get(symbol = "AAPL", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
aapl.aroon <- av_get(symbol = "AAPL", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
aapl.bbands <- av_get(symbol = "AAPL", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
aapl.ad <- av_get(symbol = "AAPL", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
aapl.obv <- av_get(symbol = "AAPL", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
apple.full <- apple %>% 
  left_join(aapl.sma,  by = "time") %>% 
  left_join(aapl.ema,  by = "time") %>%
  left_join(aapl.macd,  by = "time") %>% 
  left_join(aapl.stoch,  by = "time") %>%
  left_join(aapl.rsi,  by = "time") %>% 
  left_join(aapl.adx,  by = "time") %>%
  left_join(aapl.cci,  by = "time") %>% 
  left_join(aapl.aroon,  by = "time") %>%
  left_join(aapl.bbands,  by = "time") %>% 
  left_join(aapl.ad,  by = "time") %>%
  left_join(aapl.obv,  by = "time")

#Write to CSV
write.csv(apple.full, file = "apple.full.csv")
