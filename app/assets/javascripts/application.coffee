#= require jquery2
#= require jquery_ujs
#= require underscore
#= require moment
#= require highstock
#= require highstock/highcharts-more
#= require material
#= require toast

#= require lib/yfapi_request_builder
#= require lib/yfapi_data_fetcher
#= require lib/yfapi_data_converter
#= require lib/portfolio
#= require lib/draw_chart
#= require lib/application_facade

# Global application facade.
appFacade = new window.app.ApplicationFacade(window.app, gon)

$ -> appFacade.bindThemAll(
  gon, '#portfolio-chart-generator', '#portfolio-stock-form-shower')
