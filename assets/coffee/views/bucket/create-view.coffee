define (require) ->
  'use strict'

  View        = require 'views/base/view'
  Template    = require 'templates/bucket-new'

  class BucketCreateView extends View
    template:   Template
    id:         'bucket-create'

    initialize: () ->
      @model.syncing => @$el.find('div.icon').addClass('entypo loading')
      @model.synced => @$el.find('div.icon').removeClass('loading warning').addClass('entypo check')
      @model.unsynced => @$el.find('div.icon').removeClass('loading check').removeClass('entypo warning')

    render: () ->
      super
      setTimeout () => 
        @model.save()
      , 1000 # make sure transform is done
