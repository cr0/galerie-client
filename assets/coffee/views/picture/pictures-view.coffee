define (require) ->
  'use strict'

  require 'jquery.mousewheel'

  CollectionView  = require 'views/base/collection-view'
  ItemView        = require 'views/picture/picture-view'
  Template        = require 'templates/picture-items'
  AddTemplate     = require 'templates/picture-add'


  class PicturesView extends CollectionView
    template:     Template
    itemView:     ItemView
    className:    'horizontal-scroll'
    listSelector: 'ul.pictures'
    eventhandler: no

    events:
      'click a.fileupload': 'openFileDialogue'
    
    initialize: ->
      @addCollectionListeners()

    renderAllItems: ->
      super
      if not @eventhandler
        @eventhandler = yes
        console.debug 'Adding scrollwheel..'
        @$el.children(@listSelector).first().mousewheel (event, delta) ->
          @scrollLeft -= delta
          event.preventDefault()

      @$el.children(@listSelector).first().append(AddTemplate())

    openFileDialogue: ->
      $(document).find('input:file').first().click()