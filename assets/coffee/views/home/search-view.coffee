define (require) ->
  'use strict'

  require 'jquery-autosize'

  _               = require 'underscore'

  View            = require 'views/base/view'

  Template        = require 'templates/home/search'


  class SearchView extends View
    @PLACEHOLDER: [
      'Motorradtour in den Alpen 2013', 'Was war vor einem Jahr?', 'Zeig mir ein zufälliges Album!',
      'Der letzte Geburtstag', 'Geburtstag von Christian Roth in 2012', '!hilfe', '#geburtstag #kassler',
      'Irgendeine Feier', 'Fotos in meiner Gegend', 'Fotos aus Regensburg'
    ]

    template: Template
    regions:
      'stats': '.stats'
    bindings:
      '.user.reputation':
        observe:      'reputation'
        afterUpdate:  'highlight'


    initialize: ->
      @delegate 'focus', 'textarea.search', (e) -> $(e.target).autosize()
      @delegate 'keyup', 'textarea.search', (e) =>
        if not $(e.target).val() then @_animate $(e.target), _.sample(SearchView.PLACEHOLDER)


    render: ->
      super

      @_animate @$el.find('textarea.search'), _.sample(SearchView.PLACEHOLDER)


    _animate: ($textarea, placeholder) =>
      i = 0
      int = window.setInterval =>
        if i is placeholder.length
          window.clearInterval int
          window.setTimeout =>
            if not $textarea.val()
              @_animate $textarea, _.sample(SearchView.PLACEHOLDER)
          , 8000
          return

        $textarea.attr('placeholder', placeholder[0..i++])
        $textarea.trigger('autosize.resize')
      ,  _.random(5, 250)
