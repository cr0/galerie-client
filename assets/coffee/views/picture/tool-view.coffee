define (require) ->
  'use strict'

  require 'vendor/jquerypp/dom/form_params'

  View            = require 'views/base/view'
  Tags            = require 'models/tags'
  Bucket          = require 'models/bucket'
  Template        = require 'templates/picture-tool'


  class PictureToolView extends View
    template:   Template

    events:
      'click #create-bucket': 'showCreateBucket'
      'submit form.create-bucket': 'createBucket'

    showCreateBucket: ->
      @$el.parent().toggleClass('fullheight')

    createBucket: (e) ->
      e.preventDefault()

      submitBtn = @$el.find('form.create-bucket > button[type=submit]').first()
      form = @$el.find('form.create-bucket').formParams()

      bucket = new Bucket
        name:         form.name
        description:  form.description
        tags:         form.tags.split(', ')

      submitBtn.attr('disabled', yes)

      bucket.save
        success: (bucket) =>
          console.log 'new bucket received from server', bucket
          submitBtn.attr('disabled', no)

        error: (bucket, err) =>
          console.error "unable to create bucket: #{err}"
          submitBtn.attr('disabled', no)