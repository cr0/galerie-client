define [
  'lib/utils'
  'controllers/base/controller'
  'views/error-view'
], (utils, Controller, ErrorView) ->
  'use strict'

  class StaticController extends Controller

    imprint: (params) ->
      @adjustTitle 'Imprint'
      
      utils.pageTransition $('#imprint'), 'bottom'


