window.app = window.app || {}

# YahooFinanceAPI ajax requester class.
class YFAPIDataFetcher
  constructor: ->

  # Registrates YFAPIRequestBuidler's query generator.
  #
  # @param {Function} queryGenerator
  setQueryGenerator: (queryGenerator) ->
    @queryGenerator = queryGenerator

  # @param {Function} doneCallback Gets an array of queries results.
  # @param {Function} failCallback Gets an error data.
  fetchData: (doneCallback, failCallback) ->
    console.log('FETCHING...')

    # Two queries to YahooFinance for 2015-2014 and 2014-2013 ranges.
    $.when( $.getJSON(@queryGenerator()), $.getJSON(@queryGenerator()) ).then(
      (firstRes, secRes) -> doneCallback([firstRes[0], secRes[0]]),
      (firstRes, secRes) -> failCallback(data)
    )

window.app.YFAPIDataFetcher = YFAPIDataFetcher