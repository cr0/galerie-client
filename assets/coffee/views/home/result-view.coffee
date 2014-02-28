define (require) ->
  'use strict'

  require 'lib/jquery-addons'

  _           = require 'underscore'

  View        = require 'views/base/view'

  Template    = require 'templates/home/result'


  class ResultView extends View
    template:   Template
    className:  'result-item'
    noWrap:     yes


    render: ->
      super

      $.loadImage(@$el.data('preview'))
        .done ($image) =>
          @$el.css
            'background-image': "url(#{$image.attr('src')})"
            'background-size': 'cover'
        .fail ($image) =>
          @$el.css 'background-color', "rgba(247,80,90,#{_.random(0.50, 1)})"
          console.error 'error loading image', $image.attr('src')
