define (require) ->
  'use strict'

  require 'backbone.stickit'

  Chaplin       = require 'chaplin'


  class View extends Chaplin.View
    autoRender: true

    getTemplateFunction: -> @template

    getTemplateData: ->
      data = super
      data.apiRoot = Chaplin.mediator.apiRoot
      data

    render: ->
      super
      @stickit() if @model
      @trigger 'rendered'

    dispose: ->
      window.setTimeout () =>
        super
        @unstickit() if @model
      , 600

    highlight: ($el, val, options) ->
      $el.fadeOut 500, () -> $(this).fadeIn(500)
