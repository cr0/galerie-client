define (require) ->
  'use strict'

  View        = require 'views/base/view'
  PicturesView= require 'views/picture/pictures-view'
  UploadView  = require 'views/picture/upload-view'

  Template    = require 'templates/bucket-index'


  class BucketView extends View
    template:   Template
    id:         'bucket-index'
    containerMethod: 'html'

    regions:
      'loading':  'div.loading'
      'pictures': 'div.pictures'
      'upload':   'div.upload'

    render: ->
      super
      @model.fetch
        success: => @create()
        error: => @publishEvent '!error', new Error 'Unable to load bucket from server'

    create: ->
      picturesView = new PicturesView region: 'pictures', collection: @model.get('pictures') 
      @subview 'pictures', picturesView

      uploadView = new UploadView region: 'upload', model: @model
      @subview 'upload', uploadView

      @$el.children('.loading').first().fadeOut 'slow', =>
        @$el.children('.pictures').first().fadeIn('slow')
        @$el.children('.upload').first().fadeIn('slow')
