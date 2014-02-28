define [
  'jquery'
  'chaplin'
  'views/base/view'
  'templates/footer'
], ($, Chaplin, View, Template) ->
  'use strict'

  class FooterView extends View
    container:  'footer'
    template:   Template

    rendered:   no

    bindings:
      '.user.reputation': 
        observe:      'reputation'
        afterUpdate:  'highlight'
      '.user.name':       'name'

    initialize: ->
      super
      @subscribeEvent 'loggedin', @updateFooter
      @subscribeEvent 'loggedout', @updateFooter

    render: ->
      super
      @rendered = yes
      @updateFooter()

    updateFooter: =>
      if not @rendered then return

      if @model?.get 'loggedin'
        @$el.find('.login').hide()
        @$el.find('.logout').show()
      else 
        @$el.find('.login').show()
        @$el.find('.logout').hide()


     