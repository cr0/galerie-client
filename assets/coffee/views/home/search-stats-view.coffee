define (require) ->
  'use strict'

  require 'jquery-countTo'

  View        = require 'views/base/view'

  Template    = require 'templates/home/search-stats'


  class SearchStatsView extends View
    template: Template

    attach: ->
      super
      @$el.find('.countto').countTo speed: 4000
