9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

mcdonald <- av_get(symbol = "MCD", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
mcdonald <- mcdonald %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
mcd.sma <- av_get(symbol = "MCD", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
mcd.ema <- av_get(symbol = "MCD", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
mcd.macd <- av_get(symbol = "MCD", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
mcd.stoch <- av_get(symbol = "MCD", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
mcd.rsi <- av_get(symbol = "MCD", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
mcd.adx <- av_get(symbol = "MCD", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
mcd.cci <- av_get(symbol = "MCD", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
mcd.aroon <- av_get(symbol = "MCD", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
mcd.bbands <- av_get(symbol = "MCD", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
mcd.ad <- av_get(symbol = "MCD", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
mcd.obv <- av_get(symbol = "MCD", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
mcdonald.full <- mcdonald %>% 
  left_join(mcd.sma,  by = "time") %>% 
  left_join(mcd.ema,  by = "time") %>%
  left_join(mcd.macd,  by = "time") %>% 
  left_join(mcd.stoch,  by = "time") %>%
  left_join(mcd.rsi,  by = "time") %>% 
  left_join(mcd.adx,  by = "time") %>%
  left_join(mcd.cci,  by = "time") %>% 
  left_join(mcd.aroon,  by = "time") %>%
  left_join(mcd.bbands,  by = "time") %>% 
  left_join(mcd.ad,  by = "time") %>%
  left_join(mcd.obv,  by = "time")

#Write to CSV
write.csv(mcdonald.full, file = "mcdonald.full.csv")
