window.app = window.app || {}

# YahooFinance API Request builder class.
class YFAPIRequestBuilder

  # Initializer of standard query templates.
  constructor: ->
    @uriParts =
      uri:   "https://query.yahooapis.com/v1/public/yql?"
      query: "q=__QUERY_PLACEHOLDER__
              &format=json&diagnostics=true
              &env=store://datatables.org/alltableswithkeys"

    @YQLTemplate = "select * from yahoo.finance.historicaldata
                    where symbol in ('__SYMBOLS_PLACEHOLDER__')
                      and startDate = '__START_DATE_PLACEHOLDER__'
                      and endDate = '__END_DATE_PLACEHOLDER__'"

    @LAST_SUPPORTED_DATE  = '2015-07-01'
    @STANDARD_DATE_FORMAT = 'YYYY-MM-DD'

  # Date string generator for YQL requests with one year offseting.
  #
  # @param {Integer} yearDelta Delta for offseting the date by years.
  # @returns {String}
  generateDate: (yearDelta) ->
    moment(@LAST_SUPPORTED_DATE).subtract(yearDelta, 'years').format(@STANDARD_DATE_FORMAT)

  # Generates an anonimous generator-function (clojure), which will return
  # YahooFinance API Request with specific start date and end date.
  # Each invokation of this clojure will return a special query request with
  # reduced startDate by 1 year param and reduced endDate param by 1 year too.
  # First invokation reduces only startDate. Each next invokation: both dates.
  #
  # @param {Array} stockSymbols Array of stock symbols (AAPL, GOOG, etc).
  # @returns {Function} Uri generator.
  buildQueryGenerator: (stockSymbols) ->
    yearDelta = 0
    =>
      query = @YQLTemplate.
        replace(/__SYMBOLS_PLACEHOLDER__/gi,    stockSymbols.join("','")).
        replace(/__END_DATE_PLACEHOLDER__/gi,   this.generateDate(yearDelta)).
        replace(/__START_DATE_PLACEHOLDER__/gi, this.generateDate(++yearDelta))

      encodeURI(@uriParts.uri.concat @uriParts.query.replace(/__QUERY_PLACEHOLDER__/gi, query))

window.app.YFAPIRequestBuilder = YFAPIRequestBuilder
