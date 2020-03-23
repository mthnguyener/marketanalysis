9/22/2010 - 3/20/2020

sector <- av_get(av_fun = "SECTOR")

tesla <- av_get(symbol = "TSLA", av_fun = "TIME_SERIES_DAILY_ADJUSTED", outputsize = "full")
tesla <- tesla %>%
  rename(c(time="timestamp"))

#Write to CSV
write.csv(tesla.full, file = "tesla.full.csv")

#Simple moving average (SMA) values
tsla.sma <- av_get(symbol = "TSLA", av_fun = "SMA", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date)

#Exponential moving average (EMA) values
tsla.ema <- av_get(symbol = "TSLA", av_fun = "EMA", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#Moving average convergence / divergence (MACD) values
tsla.macd <- av_get(symbol = "TSLA", av_fun = "MACD", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#Stochastic oscillator (STOCH) values
tsla.stoch <- av_get(symbol = "TSLA", av_fun = "STOCH", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#Relative strength index (RSI) values
tsla.rsi <- av_get(symbol = "TSLA", av_fun = "RSI", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#Average directional movement index (ADX) values
tsla.adx <- av_get(symbol = "TSLA", av_fun = "ADX", interval = "daily", time_period = 30, series_type = "close") %>%
  mutate(time = as.Date(time))

#Commodity channel index (CCI) values
tsla.cci <- av_get(symbol = "TSLA", av_fun = "CCI", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#Aroon (AROON) values
tsla.aroon <- av_get(symbol = "TSLA", av_fun = "AROON", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#Bollinger bands (BBANDS) values
tsla.bbands <- av_get(symbol = "TSLA", av_fun = "BBANDS", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#Chaikin A/D line (AD) values
tsla.ad <- av_get(symbol = "TSLA", av_fun = "AD", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#On balance volume (OBV) values
tsla.obv <- av_get(symbol = "TSLA", av_fun = "OBV", interval = "daily", time_period = 60, series_type = "close") %>%
  mutate(time = as.Date(time))

#VIX daily
vix <- read.csv("vix.daily.csv", header=T, na.strings="?")
vix <- vix %>%
  rename(c(time="Date"),
         c(vix.open="VIX.Open"),
         c(vix.high="VIX.High"),
         c(vix.low="VIX.Low"),
         c(vix.close="VIX.Close")) %>%
  mutate(time = as.Date(time, format="%m/%d/%Y"))

#Combine
tesla.full <- tesla %>% 
  left_join(vix, by = "time") %>%
  left_join(tsla.sma,  by = "time") %>% 
  left_join(tsla.ema,  by = "time") %>%
  left_join(tsla.macd,  by = "time") %>% 
  left_join(tsla.stoch,  by = "time") %>%
  left_join(tsla.rsi,  by = "time") %>% 
  left_join(tsla.adx,  by = "time") %>%
  left_join(tsla.cci,  by = "time") %>% 
  left_join(tsla.aroon,  by = "time") %>%
  left_join(tsla.bbands,  by = "time") %>% 
  left_join(tsla.ad,  by = "time") %>%
  left_join(tsla.obv,  by = "time") %>%
  na.omit()  %>%
  mutate(t = 1:nrow(tesla.full)) %>%
  select(t, everything())

#Read Data
setwd("/cloud/project/marketanalysis/Data")
tesla.full <- read.csv("tesla.full.csv", header=T, na.strings="?") %>%
  select(-X)

tesla.full <- as.data.frame(tesla.full)

#Lag Open
tesla.full <- slide(tesla.full, Var="open", NewVar="open.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="open", NewVar="open.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="open", NewVar="open.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="open", NewVar="open.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="open", NewVar="open.L5", slideBy = -5)

#Lag High
tesla.full <- slide(tesla.full, Var="high", NewVar="high.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="high", NewVar="high.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="high", NewVar="high.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="high", NewVar="high.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="high", NewVar="high.L5", slideBy = -5)

#Lag Low
tesla.full <- slide(tesla.full, Var="low", NewVar="low.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="low", NewVar="low.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="low", NewVar="low.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="low", NewVar="low.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="low", NewVar="low.L5", slideBy = -5)

#Lag Close
tesla.full <- slide(tesla.full, Var="close", NewVar="close.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="close", NewVar="close.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="close", NewVar="close.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="close", NewVar="close.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="close", NewVar="close.L5", slideBy = -5)

#Lag Adjusted Close
tesla.full <- slide(tesla.full, Var="adjusted_close", NewVar="adjusted_close.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="adjusted_close", NewVar="adjusted_close.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="adjusted_close", NewVar="adjusted_close.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="adjusted_close", NewVar="adjusted_close.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="adjusted_close", NewVar="adjusted_close.L5", slideBy = -5)

#Lag Volume
tesla.full <- slide(tesla.full, Var="volume", NewVar="volume.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="volume", NewVar="volume.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="volume", NewVar="volume.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="volume", NewVar="volume.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="volume", NewVar="volume.L5", slideBy = -5)

#Lag Dividend Amount
tesla.full <- slide(tesla.full, Var="dividend_amount", NewVar="dividend_amount.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="dividend_amount", NewVar="dividend_amount.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="dividend_amount", NewVar="dividend_amount.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="dividend_amount", NewVar="dividend_amount.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="dividend_amount", NewVar="dividend_amount.L5", slideBy = -5)

#Lag Split Coefficient
tesla.full <- slide(tesla.full, Var="split_coefficient", NewVar="split_coefficient.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="split_coefficient", NewVar="split_coefficient.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="split_coefficient", NewVar="split_coefficient.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="split_coefficient", NewVar="split_coefficient.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="split_coefficient", NewVar="split_coefficient.L5", slideBy = -5)

#Lag VIX Open
tesla.full <- slide(tesla.full, Var="vix.open", NewVar="vix.open.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="vix.open", NewVar="vix.open.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="vix.open", NewVar="vix.open.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="vix.open", NewVar="vix.open.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="vix.open", NewVar="vix.open.L5", slideBy = -5)

#Lag VIX High
tesla.full <- slide(tesla.full, Var="vix.high", NewVar="vix.high.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="vix.high", NewVar="vix.high.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="vix.high", NewVar="vix.high.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="vix.high", NewVar="vix.high.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="vix.high", NewVar="vix.high.L5", slideBy = -5)

#Lag VIX Low
tesla.full <- slide(tesla.full, Var="vix.low", NewVar="vix.low.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="vix.low", NewVar="vix.low.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="vix.low", NewVar="vix.low.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="vix.low", NewVar="vix.low.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="vix.low", NewVar="vix.low.L5", slideBy = -5)

#Lag VIX Close
tesla.full <- slide(tesla.full, Var="vix.close", NewVar="vix.close.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="vix.close", NewVar="vix.close.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="vix.close", NewVar="vix.close.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="vix.close", NewVar="vix.close.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="vix.close", NewVar="vix.close.L5", slideBy = -5)

#Lag SMA
tesla.full <- slide(tesla.full, Var="sma", NewVar="sma.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="sma", NewVar="sma.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="sma", NewVar="sma.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="sma", NewVar="sma.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="sma", NewVar="sma.L5", slideBy = -5)

#Lag EMA
tesla.full <- slide(tesla.full, Var="ema", NewVar="ema.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="ema", NewVar="ema.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="ema", NewVar="ema.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="ema", NewVar="ema.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="ema", NewVar="ema.L5", slideBy = -5)

#Lag MACD
tesla.full <- slide(tesla.full, Var="macd", NewVar="macd.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="macd", NewVar="macd.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="macd", NewVar="macd.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="macd", NewVar="macd.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="macd", NewVar="macd.L5", slideBy = -5)

#Lag MACD Hist
tesla.full <- slide(tesla.full, Var="macd_hist", NewVar="macd_hist.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="macd_hist", NewVar="macd_hist.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="macd_hist", NewVar="macd_hist.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="macd_hist", NewVar="macd_hist.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="macd_hist", NewVar="macd_hist.L5", slideBy = -5)

#Lag MACD Signal
tesla.full <- slide(tesla.full, Var="macd_signal", NewVar="macd_signal.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="macd_signal", NewVar="macd_signal.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="macd_signal", NewVar="macd_signal.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="macd_signal", NewVar="macd_signal.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="macd_signal", NewVar="macd_signal.L5", slideBy = -5)

#Lag Slowd
tesla.full <- slide(tesla.full, Var="slowd", NewVar="slowd.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="slowd", NewVar="slowd.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="slowd", NewVar="slowd.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="slowd", NewVar="slowd.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="slowd", NewVar="slowd.L5", slideBy = -5)

#Lag Slowk
tesla.full <- slide(tesla.full, Var="slowk", NewVar="slowk.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="slowk", NewVar="slowk.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="slowk", NewVar="slowk.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="slowk", NewVar="slowk.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="slowk", NewVar="slowk.L5", slideBy = -5)

#Lag RSI
tesla.full <- slide(tesla.full, Var="rsi", NewVar="rsi.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="rsi", NewVar="rsi.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="rsi", NewVar="rsi.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="rsi", NewVar="rsi.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="rsi", NewVar="rsi.L5", slideBy = -5)

#Lag ADX
tesla.full <- slide(tesla.full, Var="adx", NewVar="adx.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="adx", NewVar="adx.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="adx", NewVar="adx.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="adx", NewVar="adx.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="adx", NewVar="adx.L5", slideBy = -5)

#Lag CCI
tesla.full <- slide(tesla.full, Var="cci", NewVar="cci.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="cci", NewVar="cci.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="cci", NewVar="cci.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="cci", NewVar="cci.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="cci", NewVar="cci.L5", slideBy = -5)

#Lag Aroon Down
tesla.full <- slide(tesla.full, Var="aroon_down", NewVar="aroon_down.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="aroon_down", NewVar="aroon_down.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="aroon_down", NewVar="aroon_down.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="aroon_down", NewVar="aroon_down.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="aroon_down", NewVar="aroon_down.L5", slideBy = -5)

#Lag Aroon Up
tesla.full <- slide(tesla.full, Var="aroon_up", NewVar="aroon_up.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="aroon_up", NewVar="aroon_up.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="aroon_up", NewVar="aroon_up.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="aroon_up", NewVar="aroon_up.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="aroon_up", NewVar="aroon_up.L5", slideBy = -5)

#Lag Real Lower Band
tesla.full <- slide(tesla.full, Var="real_lower_band", NewVar="real_lower_band.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="real_lower_band", NewVar="real_lower_band.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="real_lower_band", NewVar="real_lower_band.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="real_lower_band", NewVar="real_lower_band.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="real_lower_band", NewVar="real_lower_band.L5", slideBy = -5)

#Lag Real Middle Band
tesla.full <- slide(tesla.full, Var="real_middle_band", NewVar="real_middle_band.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="real_middle_band", NewVar="real_middle_band.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="real_middle_band", NewVar="real_middle_band.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="real_middle_band", NewVar="real_middle_band.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="real_middle_band", NewVar="real_middle_band.L5", slideBy = -5)

#Lag Real Upper Band
tesla.full <- slide(tesla.full, Var="real_upper_band", NewVar="real_upper_band.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="real_upper_band", NewVar="real_upper_band.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="real_upper_band", NewVar="real_upper_band.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="real_upper_band", NewVar="real_upper_band.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="real_upper_band", NewVar="real_upper_band.L5", slideBy = -5)

#Lag Chaikin A D
tesla.full <- slide(tesla.full, Var="chaikin_a_d", NewVar="chaikin_a_d.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="chaikin_a_d", NewVar="chaikin_a_d.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="chaikin_a_d", NewVar="chaikin_a_d.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="chaikin_a_d", NewVar="chaikin_a_d.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="chaikin_a_d", NewVar="chaikin_a_d.L5", slideBy = -5)

#Lag OBV
tesla.full <- slide(tesla.full, Var="obv", NewVar="obv.L1", slideBy = -1)
tesla.full <- slide(tesla.full, Var="obv", NewVar="obv.L2", slideBy = -2)
tesla.full <- slide(tesla.full, Var="obv", NewVar="obv.L3", slideBy = -3)
tesla.full <- slide(tesla.full, Var="obv", NewVar="obv.L4", slideBy = -4)
tesla.full <- slide(tesla.full, Var="obv", NewVar="obv.L5", slideBy = -5)

