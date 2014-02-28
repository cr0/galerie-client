define (require) ->
  'use strict'

  require 'jquery.fileupload'
  require 'jquery.fileupload-ui'
  require 'jquery.resizestop'
  require 'jquery.mousewheel'
  require 'jquery.scrollto'

  Chaplin         = require 'chaplin'
  $               = require 'jquery'
  _               = require 'underscore'
  utils           = require 'lib/utils'

  Picture         = require 'models/Picture'
  Pictures        = require 'models/Pictures'

  View            = require 'views/base/view'
  PicturesView    = require 'views/picture/pictures-view'

  Template        = require 'templates/picture-upload'


  class PictureUploadView extends View
    template: Template

    initialize: ->
      @user = Chaplin.mediator.user

    render: ->
      super

      $hint         = @$el.children 'div.drop'
      $progressbar  = @$el.children 'div.progressbar.total'

      $file = $('<input>', type: 'file', name: 'files[]', multiple: true)

      $file.fileupload
        url: "/api/picture?bucket_id=#{@model.id}"
        dataType: 'json'
        autoUpload: no
        uploadTemplateId: null
        downloadTemplateId: null
        previewMaxWidth: 800
        previewMaxHeight: 500
        disableImageResize: yes
        previewThumbnail: no
        previewCrop: false

      $file.on 'fileuploadadd', (e, data) =>
        data.contexts ?= []

        if data.contexts.length is 0 then $hint.children(':first-child').hide()

        for file, i in data.files
          console.log "#{file.name} added"
          data.contexts[i] = $('<div>').addClass('container')


      $file.on 'fileuploadprocessalways', (e, data) =>
        file = data.files[data.index]
        $context = data.contexts[data.index]
        console.log "#{file.name} read (preview generated, exif extracted)"
        data.submit()

      $file.on 'fileuploadprogress', (e, data) =>
        context = data.contexts[data.index]
        context.find('.shadow').css('height', "#{100 * ( 1 - data.loaded / data.total ) }%")

      $file.on 'fileuploadprogressall', (e, data) =>
        progress = data.loaded / data.total
        if progress is 1 then $progressbar.css('height', 0) else $progressbar.css('height', 5)
        $progressbar.css('width', "#{100 * progress }%")

      $file.on 'fileuploaddone', (e, data) =>
        context = data.contexts[data.index]
        context.addClass('success').removeClass('failed')

        for pictureJson in data.result.files
          picture = new Picture(pictureJson)
          console.info "Received new picture from server", picture
          @model.get('pictures').add picture
          @user.reputation 'picture:add'


      $file.on 'fileuploadfail', (e, data) =>
        context = data.contexts[data.index]
        context.addClass('failed')
        context.find('.shadow').css('height', '100%')

        console.error "upload failed: #{data.errorThrown} - #{data.textStatus}"

      $hint.append $file