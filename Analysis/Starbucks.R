9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

starbucks <- av_get(symbol = "SBUX", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
starbucks <- starbucks %>%
  rename(c(time="timestamp"))

#Simple moving average (SMA) values
sbux.sma <- av_get(symbol = "SBUX", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close")

#Exponential moving average (EMA) values
sbux.ema <- av_get(symbol = "SBUX", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close")

#Moving average convergence / divergence (MACD) values
sbux.macd <- av_get(symbol = "SBUX", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close")

#Stochastic oscillator (STOCH) values
sbux.stoch <- av_get(symbol = "SBUX", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close")

#Relative strength index (RSI) values
sbux.rsi <- av_get(symbol = "SBUX", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close")

#Average directional movement index (ADX) values
sbux.adx <- av_get(symbol = "SBUX", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close")

#Commodity channel index (CCI) values
sbux.cci <- av_get(symbol = "SBUX", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close")

#Aroon (AROON) values
sbux.aroon <- av_get(symbol = "SBUX", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close")

#Bollinger bands (BBANDS) values
sbux.bbands <- av_get(symbol = "SBUX", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close")

#Chaikin A/D line (AD) values
sbux.ad <- av_get(symbol = "SBUX", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close")

#On balance volume (OBV) values
sbux.obv <- av_get(symbol = "SBUX", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close")

#Combine
starbucks.full <- starbucks %>% 
  left_join(sbux.sma,  by = "time") %>% 
  left_join(sbux.ema,  by = "time") %>%
  left_join(sbux.macd,  by = "time") %>% 
  left_join(sbux.stoch,  by = "time") %>%
  left_join(sbux.rsi,  by = "time") %>% 
  left_join(sbux.adx,  by = "time") %>%
  left_join(sbux.cci,  by = "time") %>% 
  left_join(sbux.aroon,  by = "time") %>%
  left_join(sbux.bbands,  by = "time") %>% 
  left_join(sbux.ad,  by = "time") %>%
  left_join(sbux.obv,  by = "time")

#Write to CSV
write.csv(starbucks.full, file = "starbucks.full.csv")
