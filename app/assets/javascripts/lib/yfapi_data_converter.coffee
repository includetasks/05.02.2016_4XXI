window.app = window.app || {}

# Simple convertation function.
# Converts YahooFinanceAPI data into readable form with necessary set of fields:
#  open, close, high, low, volume, adj_close.
#
# @returns {Object} Converted data. Form: 
# {date: { symbol: {low:INT, high:INT, ...}, symbol: {...}}, ...}
ConvertYFAPIDataToHistory = (YFAPIData) ->
  data = {}

  unless YFAPIData.query.results is null
    YFAPIData.query.results.quote.forEach (quote) ->
      data[quote.Date] = {} unless data.hasOwnProperty quote.Date
      data[quote.Date][quote.Symbol] =
        open:      quote.Open
        close:     quote.Close
        high:      quote.High
        low:       quote.Low
        volume:    quote.Volume
        adj_close: quote.Adj_Close

  return data

window.app.ConvertYFAPIDataToHistory = ConvertYFAPIDataToHistory