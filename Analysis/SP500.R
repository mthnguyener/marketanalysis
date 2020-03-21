9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

sp500 <- av_get(symbol = ".INX", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
sp500 <- sp500 %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
sp500.sma <- av_get(symbol = ".INX", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
sp500.ema <- av_get(symbol = ".INX", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
sp500.macd <- av_get(symbol = ".INX", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
sp500.stoch <- av_get(symbol = ".INX", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
sp500.rsi <- av_get(symbol = ".INX", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
sp500.adx <- av_get(symbol = ".INX", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
sp500.cci <- av_get(symbol = ".INX", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
sp500.aroon <- av_get(symbol = ".INX", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
sp500.bbands <- av_get(symbol = ".INX", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
sp500.ad <- av_get(symbol = ".INX", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
sp500.obv <- av_get(symbol = ".INX", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
sp500.full <- sp500 %>% 
  left_join(sp500.sma,  by = "time") %>% 
  left_join(sp500.ema,  by = "time") %>%
  left_join(sp500.macd,  by = "time") %>% 
  left_join(sp500.stoch,  by = "time") %>%
  left_join(sp500.rsi,  by = "time") %>% 
  left_join(sp500.adx,  by = "time") %>%
  left_join(sp500.cci,  by = "time") %>% 
  left_join(sp500.aroon,  by = "time") %>%
  left_join(sp500.bbands,  by = "time") %>% 
  left_join(sp500.ad,  by = "time") %>%
  left_join(sp500.obv,  by = "time")

#Write to CSV
write.csv(sp500.full, file = "sp500.full.csv")
