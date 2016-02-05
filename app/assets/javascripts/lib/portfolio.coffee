window.app = window.app || {}

# Portfolio class.
# Contains stocks and title.
# Generates the cost history (low, high, open, close, volume, adj_close).
class Portfolio
  # @constructor
  # @param {String} title
  # @param {Array} stocks
  constructor: (title, stocks) ->
    @title  = title
    @stocks = stocks

  # @param {Object} history Cost history. Form: { date: { symbol: {}, symbol: {} }, date: ... }
  # @returns {Object} Owns full cost history. Form: { date: { low: INT, high: INT, ...}, date: ... }
  getCostHistory: (history) ->
    costHistory = {}

    for date of history
      costHistory[date] =
        low:       0
        high:      0
        open:      0
        close:     0
        volume:    0
        adj_close: 0

      for stock in @stocks
        continue if history[date][stock.symbol] is undefined

        costHistory[date].low       += history[date][stock.symbol].low       * stock.count
        costHistory[date].high      += history[date][stock.symbol].high      * stock.count
        costHistory[date].open      += history[date][stock.symbol].open      * stock.count
        costHistory[date].close     += history[date][stock.symbol].close     * stock.count
        costHistory[date].volume    += history[date][stock.symbol].volume    * stock.count
        costHistory[date].adj_close += history[date][stock.symbol].adj_close * stock.count

    return costHistory

window.app.Portfolio = Portfolio