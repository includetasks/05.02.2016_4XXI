window.app = window.app || {}

# @param {Object} costHistory Portfolio cost story.
# @param {String} containerSelector DOM Selector of which will be used as graphic rendering area.
# @param {array} categories Standard tracked data (from history).
drawChart = (costHistory, containerSelector, categories = ['low', 'high', 'open', 'close']) ->
  seriesOptions = []
  seriesCounter = 0
  categories    = categories

  createChart = ->
    $(containerSelector).highcharts 'StockChart',
      rangeSelector: selected: 1
      yAxis:
        labels: formatter: -> @value
        plotLines: [{
          value: 0
          width: 2
          color: 'silver'
        }]
      tooltip:
        pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>'
        valueDecimals: 2
      series: seriesOptions
    return

  $.each categories, (i, name) ->

    data = []
    for date of costHistory
      data.push [moment(date).unix() * 1000, costHistory[date][name]]
    data.sort( (a, b) -> a[0] - b[0] )

    # acceptable form of highstock charts:
    # [
    #  [TIMESTAMP,DATA],
    #  [TIMESTAMP,DATA],
    #  ...
    # ]

    seriesOptions[i] =
      name: name
      data: data

    seriesCounter += 1
    if seriesCounter == categories.length
      createChart()
    return
  return

window.app.drawChart = drawChart